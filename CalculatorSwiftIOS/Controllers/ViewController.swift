//
//  ViewController.swift
//  CalculatorSwiftIOS
//
//  Created by WSR on 19/06/2019.
//  Copyright © 2019 WSR. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel! {
        didSet {
            let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
            let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
            
            rightSwipe.direction = .right
            leftSwipe.direction = .left
            resultLabel.addGestureRecognizer(rightSwipe)
            resultLabel.addGestureRecognizer(leftSwipe)
        }
    }

    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var landscapeButtons: [UIButton]! {
        didSet {
            for button in landscapeButtons {
                button.isHidden = true
            }
        }
    }
    
    var firstValue: Float = 0
    var secondValue: Float = 0
    var oper = ""
    var isPositiv = true
    var tempResult = ""
    var txtResult = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeButtons(orentation: .portrait)
    }
    
    @objc func swipe() {
        if (resultLabel.text?.count)! > 1 {
            resultLabel.text?.removeLast()
        } else {
            resultLabel.text = "0"
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        changeButtons(orentation: UIDevice.current.orientation)
    }
    
    func changeButtons(orentation: UIDeviceOrientation) {
        if orentation.isLandscape {
            for button in buttons {
                button.layer.cornerRadius = 24
            }
            for button in landscapeButtons {
                button.isHidden = false
                button.layer.cornerRadius = 24
            }
        } else {
            for button in buttons {
                button.layer.cornerRadius = 38
            }
            for button in landscapeButtons {
                button.isHidden = true
                button.layer.cornerRadius = 38
            }
        }
    }

    @IBAction func buttonClick(_ sender: UIButton) {
        
        guard var result = resultLabel.text else { return }
        guard let resultFloat = Float(result) else { return }
        
  
        if result.count >= 1 && result.first == "0" && !result.contains(".") {
            result.removeFirst()
        }
        
        if oper != "" {
            
        }

        switch sender.titleLabel?.text {
        case "%":
            if oper == "" {
                result = "\(resultFloat / 100)"
            } else {
                result = "\(Int(firstValue))"
            }
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
        case "AC":
            result = "0"
            firstValue = 0
            secondValue = 0
            oper = ""
            customize(button: nil)
        case "+":
            oper = "+"
            firstValue = resultFloat
            result = "0"
            customize(button: sender)
        case "-":
            oper = "-"
            firstValue = resultFloat
            result = "0"
            customize(button: sender)
        case "/":
            oper = "/"
            firstValue = resultFloat
            result = "0"
            customize(button: sender)
        case "x":
            oper = "x"
            firstValue = resultFloat
            result = "0"
            customize(button: sender)
        case "=":
            

            if firstValue == 0 {
                firstValue = resultFloat
            } else {
                secondValue = resultFloat
            }
            
            result = calculating()
            customize(button: nil)
            oper = ""
            
        default:
            break
        }
       
        resultLabel.text = result
        tempResult = result
    }
    
    func customize(button: UIButton?) {
        let orange = UIColor.init(red: 255/255, green: 167/255, blue: 0/255, alpha: 1)
        
        let operButtons = buttons.filter({ (btn) -> Bool in
            let label = btn.titleLabel?.text
            if label == "-" || label == "+" || label == "/" || label == "x" {
                return true
            } else {
                return false
            }
        })
        
        for item in operButtons {
            item.backgroundColor = orange
            item.setTitleColor(.white, for: .normal)
        }
        
        if button != nil {
            button!.backgroundColor = .white
            button!.setTitleColor(orange, for: .normal)
        }
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
    
    func mathOperation() {
        
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

