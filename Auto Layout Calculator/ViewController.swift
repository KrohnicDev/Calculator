//
//  ViewController.swift
//  Auto Layout Calculator
//
//  Created by Joonas Junttila on 18/11/2018.
//  Copyright © 2018 Joonas Junttila. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var numberLabel: UILabel!
    
    // MARK: Variables
    var num1 : Double?
    var num2 : Double?
    var result : Double?
    var mathOperation : MathOperation?
    var typingDecimals = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberLabel.text = "0"
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            // AC was pressed
            startOver()
        case 2:
            // +/- was pressed
            let labelAsDouble = convertToDouble(text: numberLabel.text!)
            result = reverse(number: labelAsDouble)
            
            if  numberLabel.text!.contains(".") {
                numberLabel.text = "\(result!)"
            } else {
                numberLabel.text = "\(Int(result!))"
            }
        case 3:
            // % was pressed
            let labelAsDouble = convertToDouble(text: numberLabel.text!)
            result = labelAsDouble / 100
            numberLabel.text = "\(result!)"
        case 4:
            // "/" was pressed
            if mathOperation != nil {
                calculateResult()
            }
            mathOperation = MathOperation.divide
            num1 = convertToDouble(text: numberLabel.text!)
        case 5:
            // 7 was pressed
            appendLabelText(number: 7)
        case 6:
            // 8 was pressed
            appendLabelText(number: 8)
        case 7:
            // 9 was pressed
            appendLabelText(number: 9)
        case 8:
            // "x" was pressed
            if mathOperation != nil {
                calculateResult()
            }
            mathOperation = MathOperation.multiply
            num1 = convertToDouble(text: numberLabel.text!)
        case 9:
            // 4 was pressed
            appendLabelText(number: 4)
        case 10:
            // 5 was pressed
            appendLabelText(number: 5)
        case 11:
            // 6 was pressed
            appendLabelText(number: 6)
        case 12:
            // "-" was pressed
            if mathOperation != nil {
                calculateResult()
            }
            mathOperation = MathOperation.subtract
            num1 = convertToDouble(text: numberLabel.text!)
        case 13:
            // 1 was pressed
            appendLabelText(number: 1)
        case 14:
            // 2 was pressed
            appendLabelText(number: 2)
        case 15:
            // 3 was pressed
            appendLabelText(number: 3)
        case 16:
            // "+" was pressed
            if mathOperation != nil {
                calculateResult()
            }
            mathOperation = MathOperation.add
            num1 = convertToDouble(text: numberLabel.text!)
        case 17:
            // 0 was pressed
            appendLabelText(number: 0)
        case 18:
            // "." was pressed
            typingDecimals = true
            if  !numberLabel.text!.contains(".") {
                numberLabel.text = numberLabel.text! + "."
            }
            
        case 19:
            // "=" was pressed
            calculateResult()
        default:
            return
        }
    }
    
    func appendLabelText(number: Int) {
        if convertToDouble(text: numberLabel.text!) == num1 {
           numberLabel.text = "\(number)"
        } else if typingDecimals {
            numberLabel.text = "\(numberLabel.text!)\(number)"
        } else {
            let oldNumber = convertToDouble(text: numberLabel.text!)
            let newNumber = oldNumber * 10 + Double(number)
            numberLabel.text = "\(Int(newNumber))"
        }
    }
    
    func calculate(operation: MathOperation?, num1: Double, num2: Double) -> Double {
        if let operation = operation {
            switch operation {
            case .add:
                return sum(num1: num1, num2: num2)
            case .subtract:
                return subtract(num1: num1, num2: num2)
            case .multiply:
                return multiply(num1: num1, num2: num2)
            case .divide:
                return divide(num1: num1, num2: num2)
            case .root:
                // TODO
                return 0.0
            case .square:
                // TODO
                return 0.0
            }
        }
        return num2
    }
    
    func startOver() {
        num1 = 0.0
        num2 = 0.0
        result = 0.0
        numberLabel.text = "0"
        typingDecimals = false
        mathOperation = nil
    }
    
    func convertToDouble(text: String) -> Double {
        return Double(text) ?? 0.0
    }
    
    func reverse(number: Double) -> Double {
        return 0 - number
    }
    
    func sum(num1: Double, num2: Double) -> Double {
        return num1 + num2
    }
    
    func subtract(num1: Double, num2: Double) -> Double {
        return num1 - num2
    }
    
    func multiply(num1: Double, num2: Double) -> Double {
        return num1 * num2
    }
    
    func divide(num1: Double, num2: Double) -> Double {
        return num1 / num2
    }
    
    func calculateResult(){
        if num1 == nil {
            num1 = 0.0
        }
        num2 = convertToDouble(text: numberLabel.text!)
        result = calculate(operation: mathOperation, num1: num1!, num2: num2!)
        mathOperation = nil
        var resultText = "\(result!)"
        if resultText.contains(".0") {
            resultText = "\(Int(result!))"
        }
        numberLabel.text = resultText
    }
}

