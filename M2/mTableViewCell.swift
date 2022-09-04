//
//  mTableViewCell.swift
//  M2
//
//  Created by Mohammad Alfauri on 31/08/2022.
//

import UIKit

class mTableViewCell: UITableViewCell {

    @IBOutlet weak var lbpro1: UILabel!
    @IBOutlet weak var imagepro: UIImageView!
    @IBOutlet weak var labelpro2: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupCell99(photo: UIImage,name: String,email: String){
        imagepro.image = photo
        lbpro1.text = name
        labelpro2.text = email
        }}
