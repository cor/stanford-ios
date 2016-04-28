//
//  ViewController.swift
//  calculator
//
//  Created by Cor Pruijs on 27-04-16.
//  Copyright © 2016 CorCoder. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var display: UILabel!


    // MARK: - Private Properties
    private var userIsTyping = false
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    

    // MARK: - Input Handeling
    @IBAction func operandButtonPressed(sender: UIButton) {
        
        // Extract the entered digit from the current title
        let digit = sender.currentTitle!

        // Update the displaytext depending on whether the user is typing or not
        display.text = userIsTyping ? display.text! + digit : digit
        
        // The user is now typing since he just entered a digit
        userIsTyping = true
    }
    
    @IBAction func operatorButtonPressed(sender: UIButton) {
        print(sender.currentTitle!)
    }
    
}

