//
//  ShortCutsViewController.swift
//  M2
//
//  Created by Mohammad Alfauri on 30/08/2022.
//

import UIKit
import Firebase
import FirebaseAuth

class ShortCutsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    //l1
    @IBOutlet weak var Save: UIButton!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var LastName: UITextField!
    @IBOutlet weak var FirstName: UITextField!
    @IBOutlet weak var EditingMode: UISwitch!
    @IBOutlet weak var lbldone: UILabel!
    //l1
    
    @IBOutlet weak var profiletableview: UITableView!
    var arraccount = [userprofile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //l1
        getInformation()
        setupelements()
        Save.isHidden = true
        Password.isUserInteractionEnabled = false
        Email.isUserInteractionEnabled = false
        FirstName.isUserInteractionEnabled = false
        LastName.isUserInteractionEnabled = false
        //l1
         
        
        // Do any additional setup after loading the view.
        profiletableview.delegate = self
        profiletableview.dataSource = self
        arraccount.append(userprofile.init(name: "Mohammad Ahmad", email: "test@gmail.com", photo: UIImage(named: "profile")!))
    }
    
    //l1
  
    @IBAction func EditingModeA(_ sender: Any) {
    Password.isUserInteractionEnabled = EditingMode.isOn
    Email.isUserInteractionEnabled = EditingMode.isOn
    LastName.isUserInteractionEnabled  = EditingMode.isOn
    FirstName.isUserInteractionEnabled = EditingMode.isOn
        if EditingMode.isOn{
        Save.isHidden = false
        }else {
        Save.isHidden = true
        lbldone.alpha = 0
        }
    }
    //l1
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraccount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profiletableview.dequeueReusableCell(withIdentifier: "Profilecell" ) as! ProfilTableViewCell
        let data = arraccount[indexPath.row]
        cell.setupCell(photo: data.photo, name: data.name, email: data.email)
        return cell
    }
    
    //l1
    @IBAction func SaveButton(_ sender: Any) {
        SaveInfo()
        self.showError("Updates Done")
        
    }
    //l1
    func setupelements(){
        
        lbldone.alpha = 0
    }
    func showError(_ message:String) {
        
        lbldone.text = message
        lbldone.alpha = 1
    }

func SaveInfo(){
    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    let useremail = Auth.auth().currentUser?.email
    let currentuser = Auth.auth().currentUser
    if FirstName.text != nil && Email.text != nil && LastName.text != nil {
        db.collection("users").document("\(userID!)").updateData(["firstname": FirstName.text!,"lastname": LastName.text!,"EMAIL":Email.text!])}
    if Email.text != useremail{
        currentuser?.updateEmail(to: Email.text!){ error in
            if let error = error{
                print(error)
            }
            }
        }
    if Password.text != "test1234"{
        currentuser?.updatePassword(to: Password.text!) { error in
            if let error = error{
                print(error)
            }
            }
        }
}


func getInformation(){
   let db = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    db.collection("users").whereField("uid", isEqualTo: userID!).addSnapshotListener{ (snap, err) in
    if err != nil {
print((err?.localizedDescription)!)
return
}
for i in snap!.documentChanges{
let firstnameF = i.document.get("firstname") as! String
let UserEmeilF = i.document.get("EMAIL") as! String
let lastnameF = i.document.get("lastname") as! String
DispatchQueue.main.async {
    self.FirstName.text = "\(firstnameF)"
    self.Email.text = "\(UserEmeilF)"
    self.LastName.text = "\(lastnameF)"
    self.Password.text = "test1234"
}}}}
    
}
    
    
    struct userprofile {
    let name : String
    let email : String
    let photo : UIImage
    
    
}
