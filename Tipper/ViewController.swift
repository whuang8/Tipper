//
//  ViewController.swift
//  Tipper
//
//  Created by William Huang on 12/1/16.
//  Copyright © 2016 William Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var onePersonLabel: UILabel!
    @IBOutlet weak var twoPeopleLabel: UILabel!
    @IBOutlet weak var threePeopleLabel: UILabel!
    @IBOutlet weak var fourPeopleLabel: UILabel!
    @IBOutlet weak var fivePeopleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let billAmount = defaults.double(forKey: "billAmount")
        var time = NSDate.init()
        if (defaults.object(forKey: "time") != nil){
            time = defaults.object(forKey: "time") as! NSDate
            print(time.timeIntervalSinceNow)
        }
        
        if(time.timeIntervalSinceNow <= 600 && billAmount != 0){
            billField.text = String(format: "%.2f", billAmount)
        }
        tipControl.selectedSegmentIndex = getDefaultIndex()
        billField.becomeFirstResponder()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        // Optionally initialize the property to a desired starting value
        self.firstView.alpha = 0
        self.secondView.alpha = 1
        UIView.animate(withDuration:0.4, animations: {
            // This causes first view to fade in and second view to fade out
            self.firstView.alpha = 1
            if (self.billField.text?.isEmpty)! {
                self.secondView.alpha = 0
            } else {
                self.secondView.alpha = 1
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tipControl.selectedSegmentIndex = getDefaultIndex()
        updateFields()
    }
    
    
    @IBAction func onTap(_ sender: AnyObject) {
        billField.resignFirstResponder()
        view.endEditing(true)
    }

    @IBAction func calculateTip(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        let billAmount = Double(billField.text!) ?? 0.0
        let time = NSDate()
        defaults.set(billAmount, forKey: "billAmount")
        defaults.set(time, forKey: "time")
        defaults.synchronize()
        updateFields()
        
        UIView.animate(withDuration:0.8, animations: {
            if (self.billField.text?.isEmpty)! {
                self.secondView.alpha = 0
            } else {
                self.secondView.alpha = 1

            }
        })
    }
    
    func getDefaultIndex() -> Int {
        let defaults = UserDefaults.standard
        return defaults.integer(forKey: "selectedIndex")
    }
    
    func updateFields() -> Void {
        let tipPercentages = [0.18, 0.2, 0.25]
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        let splitTwo = total / 2
        let splitThree = total / 3
        let splitFour = total / 4
        let splitFive = total / 5
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        onePersonLabel.text = String(format: "$%.2f", total)
        twoPeopleLabel.text = String(format: "$%.2f", splitTwo)
        threePeopleLabel.text = String(format: "$%.2f", splitThree)
        fourPeopleLabel.text = String(format: "$%.2f", splitFour)
        fivePeopleLabel.text = String(format: "$%.2f", splitFive)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

