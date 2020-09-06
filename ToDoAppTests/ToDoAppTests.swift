//
//  ToDoAppTests.swift
//  ToDoAppTests
//
//  Created by Ryniere dos Santos Silva on 2020-09-05.
//  Copyright © 2020 Ryniere dos Santos Silva. All rights reserved.
//

import XCTest
@testable import ToDoApp

class ToDoAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchTasks() throws {
        
        let taskService = TaskService.shared
        
        let expectation = XCTestExpectation(description: "Fetching tasks")
        
        taskService.fetchTasks(successHandler: { (tasks) in
            XCTAssertNotNil(tasks)
            expectation.fulfill()
        }) { (error) in
            
        }
        
        wait(for: [expectation], timeout: 10.0)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
