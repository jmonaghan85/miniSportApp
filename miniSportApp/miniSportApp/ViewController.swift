

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var data: Top?
    var dm: DataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        dm.loadData(url: "https://bbc.github.io/sport-app-dev-tech-challenge/data.json") { data in
            self.data = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
//
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            if let error = error {
//                print("Error fetching data: \(error.localizedDescription)")
//                return
//            }
//            
//            if let data = data {
//                do {
//                    self.data = try JSONDecoder().decode(Top.self, from: data)
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
//                } catch {
//                    print("Error decoding JSON: \(error.localizedDescription)")
//                }
//            }
//        }.resume()
        
        
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        
        header.backgroundColor = UIColor(red: 1.0, green: 0.8  , blue: 0.2, alpha: 1.0 ) 
        footer.backgroundColor = .black
        
        
        //set BBC logo and with size and centered in the header
        let logoImageView = UIImageView(image: UIImage(named: "BBCLogo"))
        logoImageView.contentMode = .scaleAspectFit
        header.addSubview(logoImageView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: header.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: header.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 80),
            logoImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        
        tableView.tableHeaderView = header
        tableView.tableFooterView = footer
        //allows grey line to go across whole row
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

//extension ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let item = data?.data.items[indexPath.row], let url = URL(string: item.url) {
//            performSegue(withIdentifier: "webpageSegue", sender: url)
//            print("Selected URL: \(url)")
            let webpageController = WebpageController(url: url)
            navigationController?.pushViewController(webpageController, animated: true)
        } else {
            print("Failed to retrieve a valid URL from the selected item")
        }
    }
    
}



extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.data.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let item = data?.data.items[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
            cell.backgroundColor = .white

            //            this checks is data?.data.topic.title is not nil, using optional binding. It wont display if not available.
            if let topicTitle = data?.data.topic.title {
                let attributedText = NSMutableAttributedString(string: "\(topicTitle)  ·  \(item.lastUpdatedText) ago")
                let greenColor = UIColor(red: 0x38 / 255.0, green: 0x7b / 255.0, blue: 0x12 / 255.0, alpha: 1.0)
                attributedText.addAttribute(.foregroundColor, value: greenColor, range: NSRange(location: 0, length: topicTitle.count))
                cell.detailTextLabel?.attributedText = attributedText
            } else {
                cell.detailTextLabel?.text = "\(item.lastUpdatedText) ago"
                cell.detailTextLabel?.textColor = UIColor.gray // Set the text color for the entire label
            }
            
            
            
            
            
            // Download and display the image
            if let imageURL = URL(string: item.image.medium) {
                URLSession.shared.dataTask(with: imageURL) { imageData, _, _ in
                    if let imageData = imageData {
                        DispatchQueue.main.async {
                            let image = UIImage(data: imageData)
                            let imageSize = CGSize(width: 80, height: 60) // Adjust the size as needed
                            cell.imageView?.contentMode = .scaleAspectFit
                            
                            UIGraphicsBeginImageContextWithOptions(imageSize, false, 0.0)
                            let imageRect = CGRect(origin: .zero, size: imageSize)
                            image?.draw(in: imageRect)
                            cell.imageView?.image = UIGraphicsGetImageFromCurrentImageContext()
                            UIGraphicsEndImageContext()
                            
                           
                            cell.setNeedsLayout() // Refresh cell layout to display the image
                        }
                    }
                }.resume()
            }
        }
        
        return cell
    }
}
