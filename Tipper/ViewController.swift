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
    g
    override func viewDidLoad() {
        super.viewDidLoad()
        tipControl.selectedSegmentIndex = getDefaultIndex()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tipControl.selectedSegmentIndex = getDefaultIndex()
        updateFields()
    }
    
    func getDefaultIndex() -> Int {
        let defaults = UserDefaults.standard
        return defaults.integer(forKey: "selectedIndex")
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }

    @IBAction func calculateTip(_ sender: AnyObject) {
        updateFields()
    }
    
    func updateFields() -> Void {
        let tipPercentages = [0.18, 0.2, 0.25]
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    

}

