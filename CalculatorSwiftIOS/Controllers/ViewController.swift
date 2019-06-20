//
//  ViewController.swift
//  CalculatorSwiftIOS
//
//  Created by WSR on 19/06/2019.
//  Copyright © 2019 WSR. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet var buttons: [UIButton]!
    
    var firstValue: Float = 0
    var secondValue: Float = 0
    var oper = ""
    var isPositiv = true
    var tempResult = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }


    @IBAction func buttonClick(_ sender: UIButton) {
        
        guard var result = resultLabel.text else { return }
        guard let resultFloat = Float(result) else { return }
        
  
        if result.count >= 1 && result.first == "0" && !result.contains(".") {
            result.removeFirst()
        }
        

        switch sender.titleLabel?.text {
        case ",":
            result = "\(result)."
        case "+/-":
            if result == "" { return }
            
            if resultFloat < 0 {
                isPositiv = false
            } else {
                isPositiv = true
            }
            
            isPositiv = !isPositiv
            
            if isPositiv {
                result.removeAll(where: {$0 == "-"})
                result = "\(result)"
            } else {
                result = "-\(result)"
            }
        case "0":
            result = "\(result)0"
        case "1":
            result = "\(result)1"
        case "2":
            result = "\(result)2"
        case "3":
            result = "\(result)3"
        case "4":
            result = "\(result)4"
        case "5":
            result = "\(result)5"
        case "6":
            result = "\(result)6"
        case "7":
            result = "\(result)7"
        case "8":
            result = "\(result)8"
        case "9":
            result = "\(result)9"
        case "C":
            result = "0"
            firstValue = 0
            secondValue = 0
        case "+":
            oper = "+"
            firstValue = resultFloat
            result = "0"
        case "-":
            oper = "-"
            firstValue = resultFloat
            result = "0"
        case "/":
            oper = "/"
            firstValue = resultFloat
            result = "0"
        case "x":
            oper = "x"
            firstValue = resultFloat
            result = "0"
        case "=":
            

            if firstValue == 0 {
                firstValue = resultFloat
            } else {
                secondValue = resultFloat
            }
            
            result = calculating()
      
            
        default:
            break
        }
        
//        if result == "" { result = "0"}
        
       
        
        resultLabel.text = result
        tempResult = result

    }
    
    func calculating() -> String {
        
        guard var result = resultLabel.text else { return "" }
        
        switch oper {
        case "+":
            result  = "\(firstValue + secondValue)"
            firstValue = secondValue
            secondValue = 0
            return floatInt(result: result)
        case "-":
            result  = "\(firstValue - secondValue)"
            firstValue = secondValue
            secondValue = 0
            return floatInt(result: result)
        case "/":
            result  = "\(firstValue / secondValue)"
            firstValue = secondValue
            secondValue = 0
            return floatInt(result: result)
        case "x":
            result  = "\(firstValue * secondValue)"
            firstValue = secondValue
            secondValue = 0
            return floatInt(result: result)
        default:
            return result
        }
    }
    
    func floatInt(result: String) -> String {
        guard let res = Float(result) else { return result}
        if res.truncatingRemainder(dividingBy: 1.0) == 0 {
            return "\(Int(res))"
        } else {
            return result
        }
    }
}

