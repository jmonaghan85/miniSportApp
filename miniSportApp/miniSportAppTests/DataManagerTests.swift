
import XCTest

@testable import miniSportApp

class DataManagerTests: XCTestCase {
    let mockJSONData = """
{
   "data":{
      "topic":{
         "title":"Formula 1",
         "url":"https://www.bbc.co.uk/sport/formula1"
      },
      "items":[
         {
            "type":"story",
            "title":"Schumacher junior wins European F3 title with race to spare",
            "url":"https://www.bbc.co.uk/sport/motorsport/45851176",
            "sectionLabel":"Formula 1",
            "sectionUrl":"https://www.bbc.co.uk/sport/formula1",
            "isLive":false,
            "lastUpdatedText":"18h",
            "mediaType":null,
            "contentType":null,
            "lastUpdatedTimestamp":1539529691,
            "image":{
               "small":"https://ichef.bbci.co.uk/onesport/cps/320/cpsprodpb/16477/production/_103855219_schumacher.jpg",
               "medium":"https://ichef.bbci.co.uk/onesport/cps/512/cpsprodpb/16477/production/_103855219_schumacher.jpg",
               "large":"https://ichef.bbci.co.uk/onesport/cps/976/cpsprodpb/16477/production/_103855219_schumacher.jpg",
               "altText":"Mick Schumacher",
               "copyrightHolder":"Getty Images"
            }
         }
    ]
}
}
""".data(using: .utf8)!

    // Test loading data from a URL
    func testLoadData() {
        let dataManager = DataManager()// Create an instance of DataManager
        let expectation = XCTestExpectation(description: "Data loaded successfully")// Create an expectation for the callback
        let mockURL = "https://www.bbc.co.uk/sport/motorsport/45851176"// Replace the URL with a mock URL for testing
        
        // Call the loadData method
        dataManager.loadData(url: mockURL) { (result: Top) in
            XCTAssertNotNil(result)
            // Add extra checks here if needed
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)// Wait for the expectation to be fulfilled or time out
    }
}
