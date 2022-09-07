//
//  chaletlistTableViewCell.swift
//  M2
//
//  Created by Mohammad Alfauri on 06/09/2022.
//

import UIKit

class chaletlistTableViewCell: UITableViewCell {

    @IBOutlet weak var chaletdescription: UILabel!
    @IBOutlet weak var chaletprice: UILabel!
    @IBOutlet weak var chaletname: UILabel!
    @IBOutlet weak var chaletphoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
