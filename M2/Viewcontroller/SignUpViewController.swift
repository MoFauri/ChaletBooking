//
//  SignUpViewController.swift
//  M2
//
//  Created by Mohammad Alfauri on 27/08/2022.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNametextfield: UITextField!
    
    @IBOutlet weak var LastNametextfield: UITextField!
    
    @IBOutlet weak var emailtextfiled: UITextField!
    
    @IBOutlet weak var passwordtextfiled: UITextField!
    
    @IBOutlet weak var singupbutton: UIButton!
    
    @IBOutlet weak var errorlabel: UILabel!
    
    
     override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         setupelements()
             
    
    }
    func setupelements(){
        
        errorlabel.alpha = 0
        
        Utilities.styleTextField(firstNametextfield)
        Utilities.styleTextField(LastNametextfield)
        Utilities.styleTextField(emailtextfiled)
        Utilities.styleTextField(passwordtextfiled)
        Utilities.styleFilledButton(singupbutton)
        
    }

    func validateFields() -> String? {
        
        
        if firstNametextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           LastNametextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailtextfiled.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
          passwordtextfiled.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
           
        let cleanedPassword = passwordtextfiled.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }
    

    
    @IBAction func singupT(_ sender: Any) {
        
        
        let error = validateFields()
        
        if error != nil {
            
            showError(error!)
        }
        else {
            let firstName = firstNametextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = LastNametextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailtextfiled.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordtextfiled.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                if err != nil {
                    
                    self.showError("Error creating user")
                }
                else {
                    
                    // User was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid ]) { (error) in
                        
                        if error != nil {
                            
                            self.showError("Error saving user data")
                        }
                    }
                    // Transition to the home screen
                    self.transitionToHome()
                }
            }
        }
    }
    
    func showError(_ message:String) {
        
        errorlabel.text = message
        errorlabel.alpha = 1
    }
    
    func transitionToHome() {
        
        let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as! HomeViewController
        navigationController?.pushViewController(homeViewController , animated: false)
        
    }
}
