//
//  NYTimesTests.swift
//  NYTimesTests
//
//  Created by Amjad Khan on 20/10/18.
//  Copyright © 2018 Amjad Khan. All rights reserved.
//

import XCTest
@testable import NYTimes

class NYTimesTests: XCTestCase {

    var article: Article?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        let jsonString = """
            { "id": 100000006160692,
                                         "title": "Among the Ruins of Mexico Beach Stands One House",
                                         "abstract": "Hurricane Michael wrecked every other beachfront house on the block, but one came through the storm nearly pristine, as if protected by grace. How did it survive?",
                          "type": "Article",
                          "published_date": "2018-10-14",
                          "byline": "By PATRICIA MAZZEI"}
 """

        guard let data = jsonString.data(using: .utf8) else {
            return
        }
        let article = try? JSONDecoder().decode(Article.self, from: data)
        XCTAssertNotNil(article)
        XCTAssertEqual(article?.title, "Among the Ruins of Mexico Beach Stands One House")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
