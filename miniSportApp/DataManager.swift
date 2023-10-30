//
//  DataManager.swift
//  miniSportApp
//
//  Created by Joanne Monaghan on 19/10/2023.
//

import UIKit

class DataManager {
    

    func loadData(url: String, callback: ((_: Top) -> Void)? = nil) {
        
        let url = URL(string: "https://bbc.github.io/sport-app-dev-tech-challenge/data.json")!
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    let fetchedData = try JSONDecoder().decode(Top.self, from: data)
                    callback?(fetchedData)
                    
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}
