//
//  LoginViewController.swift
//  M2
//
//  Created by Mohammad Alfauri on 27/08/2022.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailtextfiled: UITextField!
    
    @IBOutlet weak var passwordtextfield: UITextField!
    
    @IBOutlet weak var lginbutton: UIButton!
    
    
    @IBOutlet weak var errorlabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupelements()
    }
    func setupelements(){
       
        errorlabel.alpha = 0
        
        Utilities.styleTextField(emailtextfiled)
        Utilities.styleTextField(passwordtextfield)
        Utilities.styleFilledButton(lginbutton)
    }
    
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if emailtextfiled.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordtextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        return nil
    }
    

    @IBAction func loginT(_ sender: Any) {
        
        // TODO: Validate Text Fields
        let error = validateFields()
        
        if error != nil {
            
            // There's something wrong with the fields, show error message
            showError(error!)
        }
        else{
        
            // Create cleaned versions of the text field
        let email = emailtextfiled.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordtextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                self.errorlabel.text = error!.localizedDescription
                self.errorlabel.alpha = 1
            }
            else {
                
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as! HomeViewController
                self.navigationController?.pushViewController(homeViewController , animated: false)
            }
        }
        }
    }
    func showError(_ message:String) {
        
        errorlabel.text = message
        errorlabel.alpha = 1
    }
}
