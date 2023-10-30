

import XCTest
import WebKit
@testable import miniSportApp  

class WebpageControllerTests: XCTestCase {
    //testing it initialised with a valid url
    func testInitializationWithURL() {
        let url = URL(string: "https://www.bbc.co.uk/sport/motorsport/45851176")!
        let webpageController = WebpageController(url: url)
        
        XCTAssertEqual(webpageController.url, url)
    }
    
    // Test the initialization with invalid URL
    func testInitializationWithInvalidURL() {
        let webpageController = WebpageController(url: URL(string: "https://www.bbc.co.uk/sport")!)
        XCTAssertEqual(webpageController.url, URL(string: "https://www.bbc.co.uk/sport")!)
    }
    //
    //    // Test that the view is loaded and the web view is set
    func testLoadView() {
        let webpageController = WebpageController(url: URL(string: "https://www.bbc.co.uk/sport/motorsport/45851176")!)
        webpageController.loadView()
        XCTAssertTrue(webpageController.view is WKWebView)
        XCTAssertNotNil(webpageController.webView)
    }
    
    //    // Test that the web view is loaded with the correct URL
    func testViewDidLoad() {
        let url = URL(string: "https://www.bbc.co.uk/sport/motorsport/45851176")!
        let webpageController = WebpageController(url: url)
        webpageController.loadView()
        webpageController.viewDidLoad()
        XCTAssertEqual(webpageController.webView.url, url)
    }
    
    // Test the encoding and decoding of the URL
    func testEncodeDecode() {
        let url = URL(string:"https://www.bbc.co.uk/sport/motorsport/45851176")!
        let webpageController = WebpageController(url: url)
        
        // Encoding
        if let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: webpageController, requiringSecureCoding: false) {
            // Decoding
            if let decodedController = try? NSKeyedUnarchiver.unarchivedObject(ofClass: WebpageController.self, from: encodedData){
                XCTAssertEqual(decodedController.url, url)
            } else {
                XCTFail("Failed to decode WebpageController")
            }
        } else {
            XCTFail("Failed to encode WebpageController")
        }
    }
}








