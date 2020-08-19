//
//  ViewController.swift
//  FirstPractice
//
//  Created by Miguel Eduardo  Valdez Tellez  on 23/07/20.
//  Copyright © 2020 Miguel Eduardo  Valdez Tellez . All rights reserved.
//

import UIKit

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
    var presenter: countryServicePresenterProtocol?
    @IBOutlet weak var tableViewMain: UITableView!
    var countries: [Country] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewMain.register(UINib(nibName: "CountryCell", bundle: nil), forCellReuseIdentifier: "CountryCell")
        tableViewMain.delegate = self
        tableViewMain.dataSource = self
        //llamado a metodo
        
        
        fetchService { [weak self] (countries) in
            self?.countries = countries
            DispatchQueue.main.async {
                self?.tableViewMain.reloadData()
            }
        }
        
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


//Consumo de servicios
private func fetchService(completion: @escaping (_ countries: [Country]) -> Void) {
    //paso 2
    let endpointString = "https://restcountries.eu/rest/v2/region/americas"
    guard let endpoint = URL(string: endpointString) else {
        return
    }
    
    //paso 3
    URLSession.shared.dataTask(with: endpoint) { (data: Data?, _, error: Error?) in
        if let error = error {
            print("hubo un error: \(error.localizedDescription)")
            return
        }
        //paso 4
        guard let dataFromServices = data,
            let response: [Country] = try? JSONDecoder().decode([Country].self, from: dataFromServices) else {
                completion([])
                return
        }
        completion(response)
    }.resume()
}



