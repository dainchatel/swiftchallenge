//
//  Todo.swift
//  FoodTracker
//
//  Created by Dain Chatel on 4/19/17.
//
//

import UIKit
import os.log

class Todo: NSObject, NSCoding {
    
    //MARK: Types
    
    struct PropertyKey {
        static let name = "name"
    }
    
    //MARK: Properties
    
    var name: String
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("todos")

    //MARK: Initialization
    
    init?(name: String) {
        // Initialization should fail if there is no name
        if name.isEmpty {
            return nil
        }
        // Initialize stored properties.
        self.name = name
    }
 
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Todo object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Must call designated initializer.
        
        self.init(name: name)
    }
    
}
