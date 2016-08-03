//
//  Term.swift
//  Baito_Swift
//
//  Created by Robert Lyons on 5/24/16.
//  Copyright © 2016 Robert Lyons. All rights reserved.
//

import UIKit

class Term:NSObject, NSCoding {
    
    //MARK: Properties
    
    var term: String
    var definition: String
    
    //MARK: Types
    
    struct PropertyKey {
        static let termKey = "term"
        static let defKey = "definition"
    }
    
    //MARK: Initialization
    
    init?(term: String, definition: String){
        //set properties
        self.term = term
        self.definition = definition
        
        //if the Term obj has no term or no definition
        if(term.isEmpty && definition.isEmpty) {
            return nil
        }
    }
    
    //MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(term, forKey: PropertyKey.termKey)
        aCoder.encodeObject(definition, forKey: PropertyKey.defKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let term = aDecoder.decodeObjectForKey(PropertyKey.termKey) as! String
        let definition = aDecoder.decodeObjectForKey(PropertyKey.defKey) as! String
        self.init(term: term, definition: definition)
    }
    
}
