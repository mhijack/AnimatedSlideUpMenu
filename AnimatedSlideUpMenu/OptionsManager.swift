//
//  OptionsManager.swift
//  AnimatedSlideUpMenu
//
//  Created by Jianyuan Chen on 2021-04-27.
//

import UIKit
import Stevia

protocol OptionsManager {
    
    var options: [String]  { get }
    
    func showOptions()
}

class HomeOptionsManager: NSObject, OptionsManager {
    
    /// Use private(set) to mark the setter private
    private(set) var options: [String]
    
    private let TABLE_CELL_HEIGHT: CGFloat = 44
    
    private var tableViewHeight: CGFloat {
        return TABLE_CELL_HEIGHT * CGFloat(options.count) + (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0) /// Taking into account the bottom safe area for full-screen iphones
    }
    
    /// Views
    private var backgroundView: UIView?
    private var optionsView: UITableView?
    
    /// Action handler
    public var optionsDidOpen: (() -> ())?
    public var optionsDidDismiss: (() -> ())?
    public var didSelectOption: ((String) -> ())?
    
    init(options: [String] = []) {
        self.options = options
    }
    
}

extension HomeOptionsManager {
    
    /// Configures options view and add to screen
    public func showOptions() {
        guard backgroundView == nil else { return }
        guard let window = UIApplication.shared.windows.first else { return }
        
        /// The background view that covers the entire screen
        let backgroundView = UIView(frame: window.bounds)
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        window.subviews(backgroundView)
        backgroundView.fillContainer()
        
        /// The actual clickable options table view
        let optionsTableView = UITableView(frame: .zero, style: .plain)
        optionsTableView.isScrollEnabled = false
        optionsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        backgroundView.subviews(optionsTableView)
        
        optionsTableView
            .height(tableViewHeight)
            .leading(0)
            .trailing(0)
        optionsTableView.Width == backgroundView.Width
        optionsTableView.Bottom == backgroundView.Bottom + tableViewHeight
        optionsTableView.backgroundColor = .white
        optionsTableView.alpha = 1
        
        let backgroundTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBackground))
        backgroundView.isUserInteractionEnabled = true
        /// Ensures the tap is passed on to its subviews
        backgroundTapGesture.cancelsTouchesInView = false
        backgroundView.addGestureRecognizer(backgroundTapGesture)
        
        self.backgroundView = backgroundView
        self.optionsView = optionsTableView
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            optionsTableView.bottomConstraint?.constant = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, animations: {
                
                /// Introduces half alpha and forces a layout pass
                backgroundView.alpha = 0.5
                backgroundView.layoutIfNeeded()
                
            }) { (complete) in
                
                self.optionsDidOpen?()
                
            }
        }
    }
    
    /// Dismiss background view and options view when background is tapped
    @objc private func didTapBackground() {
        dismiss()
    }
    
    /// Dismiss options view
    private func dismiss() {
        self.optionsView?.bottomConstraint?.constant = tableViewHeight
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, animations: {
            self.backgroundView?.alpha = 0
            self.backgroundView?.layoutIfNeeded()
        }) { (complete) in
            self.backgroundView?.removeFromSuperview()
            self.backgroundView = nil
            self.optionsDidDismiss?()
        }
    }
    
}

extension HomeOptionsManager: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TABLE_CELL_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectOption?(options[indexPath.row])
    }
    
}
