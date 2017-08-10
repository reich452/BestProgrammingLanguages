//
//  Survey.swift
//  BestProgrammingLanguanges
//
//  Created by Nick Reichard on 8/10/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.

//  What do we need
// 1) Properties & keys
// 2) failable init: - to convert our JSON into our model object. 
// 3) memberwize init - to crate instances of our model 
// 4) Dictionary Rep: - Represents our model object as a Dictionary
// 5) Data for the JSON.data

import Foundation

class Survey {
    
    private let languageKey = "language"
    private let yearKey = "year"
    private let uuidKey = "uuid"
    
    // MARK: - Properties 
    
    let language: String
    let year: String
    let uuid: UUID  /// - like a timestamp - right then and there
    
    
    // Memberwize- This is for creating instances of our model object.
    
    init(language: String, year: String, uuid: UUID = UUID()) {
        self.language = language
        self.year = year
        self.uuid = uuid
    }
    
    // MARK: - Failable - this is for coming down from Firebase to convert a dictionary(JSON) into our model 

    init?(jsonDictionary: [String: Any], identifier: String) {
        guard let language = jsonDictionary[languageKey] as? String,
            let year = jsonDictionary[yearKey] as? String,
            let uuid = UUID(uuidString: identifier) else { return nil }
        
        self.language = language
        self.year = year
        self.uuid = uuid
    }
    
    
    var dictionaryRepresentaion: [String: Any] {
        let dictionary: [String: Any] = [
            languageKey: language,
            yearKey: year,
            uuidKey: uuid.uuidString
        ]
        return dictionary
    }
    
    // MARK: - PUT
    // Turn or serialize dictionaryRep into data
    // Returns JSON data from our object - to go up to Firebase. Firebase is JSON!!!
    
    var jsonData: Data? {
        return try? JSONSerialization.data(withJSONObject: dictionaryRepresentaion, options: .prettyPrinted)
    }

}

