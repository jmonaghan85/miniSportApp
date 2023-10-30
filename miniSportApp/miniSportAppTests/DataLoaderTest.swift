//
//  DataLoaderTest.swift
//  miniSportAppTests
//
//  Created by Joanne Monaghan on 23/10/2023.
//

import XCTest
@testable import miniSportApp

final class DataLoaderTest: XCTestCase {
    func testCanParseData() throws {
        //        ------use test file for json data:-----
        guard let pathString = Bundle(for: type(of: self)).url(forResource: "News", withExtension: "json") else {
                    fatalError("json not found")
                }
                print("\n\n\(pathString)\n\n")
        
                guard let json = try? Data(contentsOf: pathString) else {
                    fatalError("Unable to convert json to String")
                }

        let news = try? JSONDecoder().decode(Top.self, from: json)
        //check if news is not nil
        XCTAssertNotNil(news)
        
        // Access the item's title
        if let item = news?.data.items.first {
            XCTAssertEqual("Schumacher junior wins European F3 title with race to spare", item.title)
            XCTAssertEqual("https://www.bbc.co.uk/sport/motorsport/45851176", item.url)
            XCTAssertEqual("18h", item.lastUpdatedText)
            XCTAssertEqual("Formula 1", item.sectionLabel)
        } else {
            XCTFail("Item not found")
        }
    }
    
    
    func testCanParseWithEmptyString() throws{
        let json = """
            {
            "data":{
              "topic":{
                 "title":"Formula 1",
                 "url":"https://www.bbc.co.uk/sport/formula1"
              },
              "items":[
                 {
                    "type":"story",
                    "title":"",
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
            """

        let data = json.data(using: .utf8)!
        let news = try? JSONDecoder().decode(Top.self, from: data)
        
        // Access the item's title
        if let item = news?.data.items.first {
            XCTAssertEqual("", item.title)
        } else {
            XCTFail("Item not found")
        }
    }
    
}



