//
//  dataLoaded.swift
//  miniSportApp
//
//  Created by Joanne Monaghan on 04/10/2023.
//

import UIKit

public class DataLoader {
    
    @Published var newsData: Top?
    
    init() {
        load()
        //sort()
    }
    
    func load() {
        
        let url = URL(string: "https://bbc.github.io/sport-app-dev-tech-challenge/data.json")!
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
           
            if let data = data {
                print(data)
                let news = try? JSONDecoder().decode(Top.self, from: data)
//               print(news)
                self.newsData = news!
            }}.resume()
        
        
//        if let fileLocation = Bundle.main.url(forResource: "data", withExtension: "json") {
//            //do catch in case of an error
//            do {
//                let data = try Data(from: fileLocation as! Decoder)
//                let jsonDecoder = JSONDecoder()
//                let dataFromJson = try jsonDecoder.decode(newsData.self, from: data)
//                
//                self.newsData = dataFromJson
//            } catch {
//                    print(error)
//            }
//        }
    }
    
    //func sort() {
      //  self.newsData = self.newsData.sorted(by: {$0.lastUpdatedTimestamp < $1.lastUpdatedTimestamp })
    //}
}

