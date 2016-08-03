//
//  Set.swift
//  Baito_Swift
//
//  Created by Robert Lyons on 5/24/16.
//  Copyright © 2016 Robert Lyons. All rights reserved.
//

import UIKit

class Set:NSObject, NSCoding {
    
    //MARK: Properties
    
    var name: String!
    var terms: [Term]
    
    //MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let termArray = "terms"
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("sets")
    
    //MARK: Initialization
    
    init?(name: String, terms: [Term]){
        //set properties
        self.name = name
        self.terms = terms
        super.init()
        
        //if the set has no name or no terms
        if(name.isEmpty && terms.isEmpty) {
            return nil
        }
    }
    
    //MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        
        //workaround for storing array of optionals
        //let aTerms: [AnyObject] = terms.map { $0 as! AnyObject }
        aCoder.encodeObject(terms, forKey: PropertyKey.termArray)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        
        // workaround for storing array of optionals
        let aTerms = aDecoder.decodeObjectForKey(PropertyKey.termArray) as! [Term]
        //let terms : [Term?] = aTerms.map({ $0 as? Term })
        
        self.init(name: name, terms: aTerms)
    }
    
}