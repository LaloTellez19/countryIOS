//
//  ViewController.swift
//  FirstPractice
//
//  Created by Miguel Eduardo  Valdez Tellez  on 23/07/20.
//  Copyright © 2020 Miguel Eduardo  Valdez Tellez . All rights reserved.
//

import UIKit
import Foundation

struct Country: Codable {
    let name: String
    let alpha2Code: String
    let capital: String
    let flag: String
}
var nameSelectec = ""
var capitalSelectec = ""
var codeSelectec = ""
var flagSelect = "https://scoopak.com/wp-content/uploads/2013/06/free-hd-natural-wallpapers-download-for-pc.jpg"


class ViewController: UIViewController, countryServiceViewProtocol {
    func returnCountry(paises: [Country]) {
        self.countries = paises
        DispatchQueue.main.async{
            self.tableViewMain.reloadData()
        }
    }
    
    var presenter: countryServicePresenterProtocol?
    @IBOutlet weak var tableViewMain: UITableView!
    var countries: [Country] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewMain.register(UINib(nibName: "CountryCell", bundle: nil), forCellReuseIdentifier: "CountryCell")
        tableViewMain.delegate = self
        tableViewMain.dataSource = self
        presenter?.regresarPaises()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "change_screen"{
            let segundVista = segue.destination as! CountryViewController
            segundVista.nameSelectec = nameSelectec
            segundVista.capitalSelectec = capitalSelectec
            segundVista.codeSelectec = codeSelectec
            segundVista.flagSelectec = flagSelect
        }
    }
}

//TABLA
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        nameSelectec = countries[indexPath.row].name
        capitalSelectec = countries[indexPath.row].capital
        codeSelectec = countries[indexPath.row].alpha2Code
        performSegue(withIdentifier: "change_screen", sender: nil)
    }
}
extension ViewController: UITableViewDataSource {
    // 1. Número de filas que tendrá nuestra tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    // 2. Método para saber que celdas deben mostrarse.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell",
                                                 for: indexPath)
        if let newCell = cell as? CountryCell {
            DispatchQueue.main.async {
                let country = self.countries[indexPath.row]
                newCell.setupCell(name: country.name, capital: country.capital, code: country.alpha2Code, flag: flagSelect)
            }
        }
        return cell
    }
}
