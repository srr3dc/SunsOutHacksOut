//
//  NewViewController.swift
//  locationv2
//
//  Created by Samantha 2 on 8/29/20.
//  Copyright © 2020 Samantha 2. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Foundation

protocol SegueHandlerType{
    associatedtype SegueIdentifier: RawRepresentable
}

class NewViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {

    private var run: Run?
    
    
    @IBOutlet weak var monstersTextField: UILabel!
    @IBOutlet weak var monsterPicker: UIPickerView!
    
    let monsters = ["Rock", "Zombie", "Witch", "Wereman", "Vampire"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return monsters.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return monsters[row] }
    
    func pickerView(_pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        monstersTextField.text = monsters[row]
        
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()

    }

    
override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
}
    
}

struct Constants{
    static let picked = "monsters[row]"
}



