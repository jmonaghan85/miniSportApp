//
//  ViewController.swift
//  miniSportApp
//
//  Created by Joanne Monaghan on 02/10/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var data: Top?
    
    /*[
        ["Lewis Hamilton","Max Verstappen","Fernando Alonso","Sebastian Vettel"],
        ["Japanese Grand Prix", "Monaco Grand Prix"],
        ["Silverstone"]
    ]*/

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let url = URL(string: "https://bbc.github.io/sport-app-dev-tech-challenge/data.json")!
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
           
            if let data = data {
                print(data)
                let news = try? JSONDecoder().decode(Top.self, from: data)
//               print(news)
                self.data = news!
            }}.resume()
//        print(data)
        
        
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        
        header.backgroundColor = .yellow
        footer.backgroundColor = .black
        
        let label = UILabel(frame:header.bounds)
        label.text = "BBC"
        label.textAlignment = .center
        header.addSubview(label)
        
        tableView.tableHeaderView = header
        tableView.tableFooterView = footer
        
    }


}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
     /*func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }*/
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return data?.data.items.count ?? 0
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return data?.data.items.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data?.data.items[indexPath.item].title
        cell.backgroundColor = .gray
        print(data?.data.items)
        return  cell
    }
}
