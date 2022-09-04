//
//  mViewController.swift
//  M2
//
//  Created by Mohammad Alfauri on 31/08/2022.
//

import UIKit

class mViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mntablevieww: UITableView!
    var arrm = [m99]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mntablevieww.dataSource = self
        mntablevieww.delegate = self
        arrm.append(m99.init(name: "Mohammad Ahmad", email: "test@gmail.com", photo: UIImage(named: "heart")!))
        arrm.append(m99.init(name: "Mohammad Ahmad", email: "test@gmail.com", photo: UIImage(named: "profile")!))
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrm.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mntablevieww.dequeueReusableCell(withIdentifier: "mcell")as! mTableViewCell
        let data = arrm[indexPath.row]
        cell.setupCell99(photo: data.photo, name: data.name, email: data.email)
        return cell
    }
    struct m99 {
        let name : String
        let email : String
        let photo : UIImage
    }
}
