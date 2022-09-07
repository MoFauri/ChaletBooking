//
//  ChaletListingViewController.swift
//  M2
//
//  Created by Mohammad Alfauri on 06/09/2022.
//

import UIKit

class ChaletListingViewController: UIViewController {

    @IBOutlet weak var TableViewChaletlsit: UITableView!
    
    var chaletlisting: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = chaletlisting?.categoryName
        TableViewChaletlsit.dataSource = self
        TableViewChaletlsit.delegate = self
        TableViewChaletlsit.reloadData()
    }

}
extension ChaletListingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chaletlisting?.products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "chaletlistTableViewCell") as? chaletlistTableViewCell else {
         return UITableViewCell()
        }
        cell.chaletname.text = chaletlisting?.products?[indexPath.row].name
        cell.chaletprice.text = chaletlisting?.products?[indexPath.row].price
        cell.chaletdescription.text = chaletlisting?.products?[indexPath.row].description
        cell.chaletphoto.image = UIImage(named: chaletlisting?.products?[indexPath.row].imageName ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: "ChaletdetailsViewController")
                as? ChaletdetailsViewController else
        {return}
        vc.chaletdetails = chaletlisting?.products?[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
