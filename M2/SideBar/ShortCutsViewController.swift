//
//  ShortCutsViewController.swift
//  M2
//
//  Created by Mohammad Alfauri on 30/08/2022.
//

import UIKit

class ShortCutsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var profiletableview: UITableView!
    var arraccount = [userprofile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profiletableview.delegate = self
        profiletableview.dataSource = self
        arraccount.append(userprofile.init(name: "Mohammad Ahmad", email: "test@gmail.com", photo: UIImage(named: "profile")!))
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraccount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profiletableview.dequeueReusableCell(withIdentifier: "Profilecell" ) as! ProfilTableViewCell
        let data = arraccount[indexPath.row]
        cell.setupCell(photo: data.photo, name: data.name, email: data.email)
        return cell
    }
}
struct userprofile {
    let name : String
    let email : String
    let photo : UIImage
    
    
}
