//
//  consumoServicio.swift
//  FirstPractice
//
//  Created by Miguel Eduardo  Valdez Tellez  on 19/08/20.
//  Copyright © 2020 Miguel Eduardo  Valdez Tellez . All rights reserved.
//

import Foundation
import UIKit
class consumoServio
{
    static let shared = consumoServio()
    let endpointString = "https://restcountries.eu/rest/v2/region/americas"
    init(){
        
    }
    func fetchService(completion: @escaping (_ countries: [Country]) -> Void) {
        guard let endpoint = URL(string: endpointString) else {
            return
        }
        URLSession.shared.dataTask(with: endpoint) { (data: Data?, _, error: Error?) in
            if let error = error {
                print("hubo un error: \(error.localizedDescription)")
                return
            }
            guard let dataFromServices = data,
                let response: [Country] = try? JSONDecoder().decode([Country].self, from: dataFromServices) else {
                    completion([])
                    return
            }
            completion(response)
        }.resume()
    }
    
}
