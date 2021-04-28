//
//  OptionsManager.swift
//  AnimatedSlideUpMenu
//
//  Created by Jianyuan Chen on 2021-04-27.
//

import Foundation

protocol OptionsManager {
    
    var options: [String]  { get }
    
    func showOptions()
}

class HomeOptionsManager: OptionsManager {
    
    private(set) var options: [String]
    
    init(options: [String] = []) {
        self.options = options
    }
    
    /// Configures options view and add to screen
    func showOptions() {
        
    }
    
}
