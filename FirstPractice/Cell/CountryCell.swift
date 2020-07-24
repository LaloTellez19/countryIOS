//
//  CountryCell.swift
//  FirstPractice
//
//  Created by Miguel Eduardo  Valdez Tellez  on 23/07/20.
//  Copyright © 2020 Miguel Eduardo  Valdez Tellez . All rights reserved.
//

import UIKit
import SDWebImage
class CountryCell: UITableViewCell {
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        flagImageView.layer.cornerRadius = flagImageView.bounds.size.width / 2.0
    }
    
    func setupCell(name: String, capital: String, code: String,flag: String)
    {
        nameLabel.text = name
        capitalLabel.text = capital
        codeLabel.text = code
        flagImageView.sd_setImage(with: URL(string: flag))
    }
}
