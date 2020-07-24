//
//  CountryViewController.swift
//  FirstPractice
//
//  Created by Miguel Eduardo  Valdez Tellez  on 23/07/20.
//  Copyright © 2020 Miguel Eduardo  Valdez Tellez . All rights reserved.
//

import UIKit
import SDWebImage
class CountryViewController: UIViewController {
    
    
    @IBOutlet weak var flagCountryImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    
    var nameSelectec = ""
    var capitalSelectec = ""
    var codeSelectec = ""
    var flagSelectec = ""
    
    var countries: [Country] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        nameLabel.text = nameSelectec
        capitalLabel.text = capitalSelectec
        codeLabel.text = codeSelectec
        flagCountryImage.sd_setImage(with: URL(string: flagSelectec))
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
