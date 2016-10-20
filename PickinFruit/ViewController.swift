//
//  ViewController.swift
//  PickinFruit
//
//  Created by Flatiron School on 7/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var fruitPicker: UIPickerView!
    

    var fruitsArray = ["🍎", "🍊", "🍌", "🍐", "🍇", "🍉", "🍓", "🍒", "🍍"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fruitPicker.dataSource = self
        fruitPicker.delegate = self
        
        
        self.spinButton.accessibilityLabel = Constants.SPIN_BUTTON
        
        
        
    }
    
    @IBAction func spinButtonTapped(_ sender: UIButton) {
        didWin()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fruitsArray[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fruitsArray.count
    }
    
    func didWin() {
        var results = Set<Int>()
        var fruitCombo = [String]()
        var didWin: Bool {
            return results.count == 1
        }
        
        for num in 0..<3 {
            let randomNum = Int(arc4random_uniform(UInt32(fruitsArray.count)))
            fruitPicker.selectRow(randomNum, inComponent: num, animated: true)
            results.insert(randomNum)
            fruitCombo.append(fruitsArray[randomNum])
            
        }
        print(results)
        print(fruitCombo)
        resultLabel.alpha = 1
        switch didWin {
        case true:
                resultLabel.text = "WINNER!"
                UIView.animate(withDuration: 1, delay: 0, options: .repeat, animations: {
                    self.resultLabel.alpha = 0
                    }, completion: nil)
        default:
                resultLabel.text = "TRY AGAIN"
                UIView.animate(withDuration: 1) {
                    self.resultLabel.alpha = 0
            }
        }
    }

}

// MARK: Set Up
extension ViewController {
    
    override func viewDidLayoutSubviews() {
        if self.spinButton.layer.cornerRadius == 0.0 {
            configureButton()
        }
    }
    
    func configureButton()
    {
        self.spinButton.layer.cornerRadius = 0.5 * self.spinButton.bounds.size.width
        self.spinButton.layer.borderColor = UIColor.white.cgColor
        self.spinButton.layer.borderWidth = 4.0
        self.spinButton.clipsToBounds = true
    }
    
}



