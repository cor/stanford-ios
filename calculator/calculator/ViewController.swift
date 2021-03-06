//
//  ViewController.swift
//  calculator
//
//  Created by Cor Pruijs on 27-04-16.
//  Copyright © 2016 CorCoder. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var core = CalculatorCore()
    
    // MARK: - Outlets
    @IBOutlet private weak var display: UILabel!
    @IBOutlet private weak var descriptionDisplay: UILabel!
    

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
    
    private func updateDescriptionDisplay() {
        descriptionDisplay.text = core.description
        if core.resultIsPartial {
            descriptionDisplay.text! += " ..."
        }
    }

    // MARK: - Input Handeling
    @IBAction private func operandButtonPressed(sender: UIButton) {
        
        // Extract the entered digit from the current title
        let digit = sender.currentTitle!

        // Update the displaytext depending on whether the user is typing or not
        display.text = userIsTyping ? display.text! + digit : digit
        
        // The user is now typing since he just entered a digit
        userIsTyping = true
        updateDescriptionDisplay()
    }
    
    @IBAction func pointButtonPressed(sender: UIButton) {
    
        // Check if the number already contains a decimal point
        if !display.text!.containsString(".") {
            // If it doesn't, add a decimal point
            display.text! += "."
        }
        updateDescriptionDisplay()
    }
    
    @IBAction func clearButtonPressed(sender: UIButton) {
        // Reset everything
        core.reset()
        updateDescriptionDisplay()
        displayValue = core.result
    }
    
    @IBAction private func operatorButtonPressed(sender: UIButton) {
        
        if userIsTyping {
            core.setOperand(displayValue)
            userIsTyping = false
        }
        
        userIsTyping = false
        
        if let mathematicalSymbol = sender.currentTitle {
            core.performOperation(mathematicalSymbol)
        }
        
        displayValue = core.result
        updateDescriptionDisplay()
    }
    
}

