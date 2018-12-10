//
//  CarTableViewCell.swift
//  FancyCars
//
//  Created by Jordan Liu on 2018-12-07.
//  Copyright © 2018 Jordan Liu. All rights reserved.
//

import UIKit
import SDWebImage

class CarTableViewCell: UITableViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func showCar(_ car: CarViewModel) {
        photoImageView.sd_setImage(with: URL(string: car.photo), placeholderImage: UIImage(named: "placeholder.png"))
        nameLabel.text = car.name
        makeLabel.text = car.make
        modelLabel.text = car.model
        buyButton.isHidden = !car.buyVisible
        
    }
}
