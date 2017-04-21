//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Dain Chatel on 4/18/17.
//
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    //MARK: Todo Class Tests
    
    // Confirm that the Todo initializer returns a Todo object when passed valid parameters.
    func testTodoInitializationSucceeds() {
        
        // A todo
        let normalTodo = Todo.init(name: "Zero")
        XCTAssertNotNil(normalTodo)
        
    }
    
    // Confirm that the Todo initialier returns nil when passed an empty name.
    func testTodoInitializationFails() {

        // Empty String
        let emptyStringTodo = Todo.init(name: "")
        XCTAssertNil(emptyStringTodo)
        
    }
    
}
