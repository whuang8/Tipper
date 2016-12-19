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
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

