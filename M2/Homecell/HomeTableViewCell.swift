//
//  HomeTableViewCell.swift
//  M2
//
//  Created by Mohammad Alfauri on 04/09/2022.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var placesName: UILabel!
    @IBOutlet weak var collectionViewChalet: UICollectionView!
    
    var chalets: Product? {
        
        didSet {
            placesName.text =  chalets?.categoryName
            collectionViewChalet.reloadData()
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewChalet.dataSource = self
        collectionViewChalet.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onClickSeeAll(_ sender: Any) {
    }
}
extension HomeTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chalets?.products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChaletsCollectionViewCell", for: indexPath) as? ChaletsCollectionViewCell else {return UICollectionViewCell() }
        
        cell.imglbl.text = chalets?.products?[indexPath.row].name
        cell.chaletimg.image = UIImage(named: chalets?.products?[indexPath.row].imageName ?? "")
    return cell
    }
    
    
    
}
