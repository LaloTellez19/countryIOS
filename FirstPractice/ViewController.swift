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


class ViewController: UIViewController {
    
    @IBOutlet weak var tableViewMain: UITableView!
    var countries: [Country] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableViewMain.register(UINib(nibName: "CountryCell", bundle: nil), forCellReuseIdentifier: "CountryCell")
        tableViewMain.delegate = self
        fetchService()
    }
}


//Metodos para implementar tables y sus clicks
//Implemenat metodo deleate para hacer click
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("La celda #\(indexPath.row) fue seleccionada")
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
                newCell.setupCell(name: country.name, capital: country.capital, code: country.alpha2Code)
            }
            
            
        
        }
        
        return cell
    }
}

//Pasos para consumir servicios web
//EndPoint: https://restcountries.eu/rest/v2/region/americas
//1.- Crear exception de seeguridad -> Cambiar info.plist
//2.- Crear URL con el endpoint
//3.- Hacer request con la ayuda de URLSesion
//4.- Transformar respuesta a diccionario
//5.- Ejecutar request
private func fetchService()
{
    //paso 2
    let endpointString = "https://restcountries.eu/rest/v2/region/americas"
    guard let endpoint = URL(string: endpointString) else {
        return
    }
    
    //paso 3
           URLSession.shared.dataTask(with: endpoint)
           { (data: Data?, _, error: Error?) in
               
               if error != nil{
                   print("hubo un error")
                   return
               }
               //paso 4
               guard
                   let dataFromServices = data,
                   let model: Country = try?
                        JSONDecoder().decode(Country.self,
                        from: dataFromServices)else{
                            return
               }
            DispatchQueue.main.async {
                
            }
            
            
           }.resume()
    
    
}


