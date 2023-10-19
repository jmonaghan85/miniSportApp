//
//  WebpageController.swift
//  miniSportApp
//
//  Created by Joanne Monaghan on 12/10/2023.
import UIKit
import WebKit

class WebpageController: UIViewController, WKNavigationDelegate {
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
    }
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(url.absoluteString, forKey: "url")
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
    
    


