//
//  ViewController.swift
//  AnimatedSlideUpMenu
//
//  Created by Jianyuan Chen on 2021-04-27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var showOptionButton: UIBarButtonItem!
    
    @IBOutlet weak var chosenOptionLabel: UILabel!
    
    private lazy var optionsManager: OptionsManager = {
        let manager = HomeOptionsManager(options: ["Canelo", "GGG", "Mayweather"])
        manager.optionsDidOpen = {
            print("Menu is now open")
        }
        manager.optionsDidDismiss = {
            print("Menu is now dismissed")
        }
        manager.didSelectOption = { (option) in
            self.chosenOptionLabel.text = "The chosen label is: \(option)"
        }
        return manager
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapShowOptionsButton(_ sender: Any) {
        optionsManager.showOptions()
    }
    
}
