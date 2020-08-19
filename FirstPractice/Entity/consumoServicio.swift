//
//  consumoServicio.swift
//  FirstPractice
//
//  Created by Miguel Eduardo  Valdez Tellez  on 19/08/20.
//  Copyright © 2020 Miguel Eduardo  Valdez Tellez . All rights reserved.
//

import Foundation
class consumoServio
{
    static let shared = consumoServio()
    init(){}
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

}
