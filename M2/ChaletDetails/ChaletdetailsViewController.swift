//
//  ChaletdetailsViewController.swift
//  M2
//
//  Created by Mohammad Alfauri on 06/09/2022.
//

import UIKit

class ChaletdetailsViewController: UIViewController {

    @IBOutlet weak var Datailstableview: UITableView!
    
    var chaletdetails: ProductDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = chaletdetails?.name
        Datailstableview.delegate = self
        Datailstableview.dataSource = self
        Datailstableview.reloadData()
    }
    
}
extension ChaletdetailsViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "chaletlistTableViewCell") as? chaletlistTableViewCell else {
            return UITableViewCell()
        }
        cell.chaletname.text = chaletdetails?.name
        cell.chaletprice.text = chaletdetails?.price
        cell.chaletdescription.text = chaletdetails?.description
        cell.chaletphoto.image = UIImage(named: chaletdetails?.imageName ?? "")
        return cell
    }
}
