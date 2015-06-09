//
//  ViewController.swift
//  StanfordCalculator
//
//  Created by Sara OC on 05/06/2015.
//  Copyright (c) 2015 Sara OC Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    var userHasEnteredAFloatingPoint = false
    
    @IBAction func appendFloatingPoint(sender: UIButton) {
        if !userHasEnteredAFloatingPoint {
            display.text = display.text! + sender.currentTitle!
            userHasEnteredAFloatingPoint = true
        } else {}
    }

    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
            case "×": performOperation { $0 * $1 }
            case "÷": performOperation { $1 / $0 }
            case "+": performOperation { $0 + $1 }
            case "−": performOperation { $1 - $0 }
            case "√": performOperation { sqrt($0) }
            default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if internalStackOfNumbers.count >= 2 {
            displayValue = operation(internalStackOfNumbers.removeLast(), internalStackOfNumbers.removeLast())
            enter()
        }
    }
    
    private func performOperation(operation: Double -> Double) {
        if internalStackOfNumbers.count >= 1 {
            displayValue = operation(internalStackOfNumbers.removeLast())
            enter()
        }
    }
    
    var internalStackOfNumbers = Array<Double>()

    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        userHasEnteredAFloatingPoint = false
        internalStackOfNumbers.append(displayValue)
        println("internalStack = \(internalStackOfNumbers)")
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text! = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}

