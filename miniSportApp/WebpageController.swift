//
//  WebpageController.swift
//  miniSportApp
//
//  Created by Joanne Monaghan on 12/10/2023.
import UIKit
import WebKit

class WebpageController: UIViewController, WKNavigationDelegate, NSSecureCoding {
    var webView: WKWebView!
    var url: URL
    
 
    
    init(url: URL) {
        self.url = url
        print("WebpageController: Initializing with UhjgjhgjhRL - \(url.absoluteString)")
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        if let urlString = aDecoder.decodeObject(forKey: "url") as? String, let url = URL(string: urlString) {
            self.url = url
            print("WebpageController: Initializing with URL - \(url)")
        } 
        else {
            self.url = URL(string: "https://www.bbc.co.uk/sport")!
            print("WebpageController: Initializing with default URL")
        }
        super.init(nibName: nil, bundle: nil)
    }
    

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .done, target: self, action: nil)
        // share button
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonTapped))
        self.navigationItem.rightBarButtonItem = shareButton
    }
    
    // Function to handle the "square.and.arrow.up" button tap for sharing
    @objc func shareButtonTapped() {
        // Create a UIActivityViewController to share the URL
        let shareURL = [url]
        let activityViewController = UIActivityViewController(activityItems: shareURL, applicationActivities: nil)

        if let popoverPresentationController = activityViewController.popoverPresentationController {
            popoverPresentationController.barButtonItem = self.navigationItem.rightBarButtonItem
        }

        // Present the share sheet
        present(activityViewController, animated: true, completion: nil)
    }
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(url.absoluteString, forKey: "url")
    }
    static var supportsSecureCoding: Bool {
        return true
    }
    
  
}
////////////////////////////

//        webView = WKWebView()
//        webView.navigationDelegate = self
//        view = webView
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let url = URL(string: "https://www.bbc.co.uk/sport")!
//        webView.load(URLRequest(url: url))
//        webView.allowsBackForwardNavigationGestures = true

        // Do any additional setup after loading the view.

    

    /*
    // MARK: - Navigation

     */
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    


