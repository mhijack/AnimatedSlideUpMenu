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
        let manager = HomeOptionsManager(options: ["Canelo",
                                                   "GGG",
                                                   "Mayweather"])
        return manager
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func didTapShowOptionsButton(_ sender: Any) {
        
    }
    
}
