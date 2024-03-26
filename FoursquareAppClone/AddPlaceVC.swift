//
//  AddPlaceVC.swift
//  FoursquareAppClone
//
//  Created by Metehan Canpolat on 22.03.2024.
//

import UIKit

class AddPlaceVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var placeNameText: UITextField!
    @IBOutlet weak var placeTypeText: UITextField!
    @IBOutlet weak var placeCommentText: UITextField!
    @IBOutlet weak var placeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeImageView.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        placeImageView.addGestureRecognizer(gestureRecognizer)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(keyBoardClose))
        view.addGestureRecognizer(tapGesture)
    
        //viewcontrolleri direkt light a çeviren kü.ük kodd
        overrideUserInterfaceStyle = .light

    } // overview sonu
    
    @objc func keyBoardClose(){
        view.endEditing(true)
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        
        if placeNameText.text != "" && placeTypeText.text != "" && placeCommentText.text != "" {
            if let chosenImage = placeImageView.image {
                let model = PlaceModel.sharedInstance
                model.placeName = placeNameText.text!
                model.placeType = placeTypeText.text!
                model.placeComment = placeCommentText.text!
                model.placeImage = chosenImage
            }
            performSegue(withIdentifier: "toMapVC", sender: nil)
        }else {
            let alert = UIAlertController(title: "error", message: "place/ name /type / comment/ image??", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            present(alert,animated: true, completion: nil)
        }
        
       
        
    }//buton sonu
    
    @objc func chooseImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    } //
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        placeImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }

}
