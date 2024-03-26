//
//  PlacesVC.swift
//  FoursquareAppClone
//
//  Created by Metehan Canpolat on 21.03.2024.
//

import UIKit
import ParseUI

class PlacesVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var placeNameArray = [String]()
    var placeIdArray = [String]()
    var selectedPlaceId =  ""
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add , target: self, action:  #selector(addButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backtoLogin))
        
        //viewcontrolleri direkt light a çeviren kü.ük kodd
        overrideUserInterfaceStyle = .light
        
        tableView.delegate = self
        tableView.dataSource = self
        getDataFromParse()
    }
    
    func getDataFromParse() {
        let query = PFQuery(className: "Places")
        
        query.findObjectsInBackground { objects, error in
            
            if error != nil {
                self.alert(titleInput: "error", messageInput: error?.localizedDescription ?? "error")
            }else{
                if objects != nil {
                    
                    self.placeIdArray.removeAll(keepingCapacity: false)
                    self.placeNameArray.removeAll(keepingCapacity: false)
                    
                    for object in objects! {
                        if let placeName = object.object(forKey: "name") as? String{
                            if let placeId = object.objectId{
                                self.placeIdArray.append(placeId)
                                self.placeNameArray.append(placeName)
                            }
                        }
                    }
                    
                    self.tableView.reloadData()
                    
                }
            }
        }
    }
    
    //segue olmadan ne yapacağımız
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailVC
            destinationVC.chosenPlaceId = selectedPlaceId
        }
    }
    
    //rowa tıklantığında ne yapacağımız
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlaceId = placeIdArray[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    
    
    @objc func addButtonClicked(){
        self.performSegue(withIdentifier: "toAddPlaceVC", sender: nil)
        
    }
    @objc func backtoLogin(){
        
       
        
        PFUser.logOutInBackground { (error) in
            
            if error != nil {
                self.alert(titleInput: "error", messageInput: error?.localizedDescription ?? "error")
                
            }else {
                self.performSegue(withIdentifier: "toSignUpVC", sender: nil)
            }
            
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = placeNameArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeNameArray.count
    }
    
    func alert(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }

}
