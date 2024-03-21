//
//  ViewController.swift
//  FoursquareAppClone
//
//  Created by Metehan Canpolat on 19.03.2024.
//

import UIKit
import ParseUI

class SignUpVC: UIViewController {
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
        
      
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)


        
    } //viewdidload sonu
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func signInClicked(_ sender: Any) {
        
        if userNameText.text != "" && passwordText.text != "" {
            
            PFUser.logInWithUsername(inBackground: userNameText.text!, password: passwordText.text!) { user, error in
                if error != nil{
                    self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "error")
                }else {
                    //segue
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                    
                }
            }
            
        }else {
            makeAlert(titleInput: "error", messageInput: "username / password??")
        }
        
    } //signin sonu
    
    
    @IBAction func signUpClicked(_ sender: Any) {
        // kullanıcı kaydetme
        
        let user = PFUser()
        user.username = userNameText.text!
        user.password = passwordText.text!
        
        user.signUpInBackground { success, error in
            if error != nil{
                self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "error")
            }else{
                //segue
                self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
            }
        }
        
        if userNameText.text != "" && passwordText.text != ""{
            
        }else{
            makeAlert(titleInput: "error", messageInput: "username and password do not be empty")
        }
        
        
    }//signup sonu
    
    
    func makeAlert(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }


}

