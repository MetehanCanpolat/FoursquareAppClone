//
//  ViewController.swift
//  FoursquareAppClone
//
//  Created by Metehan Canpolat on 19.03.2024.
//

import UIKit
import ParseUI

class ViewController: UIViewController {
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       /* let parseObject = PFObject(className: "Fruits")
        parseObject["name"] = "banana"
        parseObject["calories"] = 150
        parseObject.saveInBackground { (success, error) in
            if error != nil {
                print(error?.localizedDescription)
            }else{
                print("uploaded")
            }
        } 
        
        let query = PFQuery(className: "Fruits")
        //çağırılan şeylere daha fazla şart koymak için:
        query.whereKey("calories", lessThan: 101)
        
        query.findObjectsInBackground { objects, error in
            if error != nil{
                print(error?.localizedDescription)
            }else{
                print(objects)
            }
        } */
        
    } //viewdidload sonu
    
    
    @IBAction func signInClicked(_ sender: Any) {
        
        
    } //signin sonu
    
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        
    }//signup sonu
    
    
    


}

