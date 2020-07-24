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
        flagImageView.clipsToBounds = true
        flagImageView.layer.cornerRadius = flagImageView.frame.width / 2
    }
    
    func setupCell(name: String, capital: String, code: String,flag: String)
    {
        nameLabel.text = name
        capitalLabel.text = capital
        codeLabel.text = code
        flagImageView.sd_setImage(with: URL(string: "https://static.independent.co.uk/s3fs-public/thumbnails/image/2017/09/12/11/naturo-monkey-selfie.jpg?w968h681"))
    }
}
