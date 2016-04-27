//
//  ViewController.swift
//  calculator
//
//  Created by Cor Pruijs on 27-04-16.
//  Copyright © 2016 CorCoder. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func operandButtonPressed(sender: UIButton) {
        displayLabel.text = sender.currentTitle!
    }
    
    @IBAction func operatorButtonPressed(sender: UIButton) {
    
    }
    
}

