//
//  CreateStudentViewController.swift
//  quan ly
//
//  Created by Admin on 10/27/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class CreateStudentViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageStudent: UIImageView!
    @IBOutlet weak var textFieldStudentName: UITextField!
    @IBOutlet weak var textFieldStudentAddress: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var classIT: ClassesEntity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldStudentName.delegate = self
        textFieldStudentAddress.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Photo
    
    @IBAction func addPhoto(_ sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageStudent.contentMode = .scaleAspectFit
            self.imageStudent.image = pickedImage
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: textField
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func creatNewStudentButton(_ sender: AnyObject) {
        let name = textFieldStudentName.text
        let address = textFieldStudentAddress.text
        
        if (name?.characters.count)! >= 1{
            if (address?.characters.count)! >= 1{
                if imageStudent.image != nil {
                    if let imageData = UIImageJPEGRepresentation(imageStudent.image!, 1.0) as NSData! {
                        
                        StudentDataManager.shared.creatNewStudent(name: name!, address: address!, dateOfBirth: datePicker.date as NSDate, picture: imageData, classes: classIT)
                    }
                }
            }
        }
        
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let studentViewController = storyBoard.instantiateViewController(withIdentifier: "StudentViewController") as! StudentViewController
//        self.present(studentViewController, animated:true, completion:nil)
        self.navigationController?.popViewController(animated: true)
    }
    
}
