//
//  ProfilTableViewCell.swift
//  M2
//
//  Created by Mohammad Alfauri on 31/08/2022.
//

import UIKit

class ProfilTableViewCell: UITableViewCell {

    @IBOutlet weak var profilimage: UIImageView!
    @IBOutlet weak var profillbl1: UILabel!
    @IBOutlet weak var profilelbl2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    
    func setupCell(photo: UIImage,name: String,email: String){
        profilimage.image = photo
        profillbl1.text = name
        profilelbl2.text = email
        }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
