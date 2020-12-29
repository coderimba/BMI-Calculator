//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {

    var calculatorBrain = CalculatorBrain()
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func heightSliderChanged(_ sender: UISlider) {
        heightLabel.text = String(format: "%.2fm", sender.value) //changes heightLabel's text to slider's current value
        
    }
    
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        //print(Int (sender.value))
        weightLabel.text = String(format: "%.0fKg", sender.value) //changes weightLabel's text to slider's current value
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let height = heightSlider.value
        let weight = weightSlider.value
        
        calculatorBrain.calculateBMI(height: height, weight: weight)
        self.performSegue(withIdentifier: "goToResult", sender: self)   //prepare func will be triggered after performSegue
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "goToResult" {   //to differentiate between our segues (in future where we might have created more than one segue to link the first View Controller to different View Controllers)
            let destinationVC = segue.destination as! ResultViewController //as! ResultViewController is to force downcast destinationVC from type UIViewController (superclass) to type ResultViewController (subclass) so the bmiValue variable can be accessed (it is our job to narrow down the data type and specify the exact data type the destination will be)
            destinationVC.bmiValue = calculatorBrain.getBMIValue()
            destinationVC.advice = calculatorBrain.getAdvice()
            destinationVC.color = calculatorBrain.getColor()
        }
    }
}

