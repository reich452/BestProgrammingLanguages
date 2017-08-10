//
//  SureveyController.swift
//  BestProgrammingLanguanges
//
//  Created by Nick Reichard on 8/10/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation

class SurveyController {
    
    // Source of Truth
    static var surveys: [Survey] = []
    
    static let baseURL = URL(string: "https://bestprogramminglanguage2-3947e.firebaseio.com/languages")
    
    static func putSurveyWith(language: String, year: String, completion: @escaping (_ success: Bool) -> Void) {
        
        // Create an instance of Survey
        let survey = Survey(language: language, year: year)
        
        guard let unwrappedURL = baseURL else { fatalError("Broken URL")}
        
        let url = unwrappedURL.appendingPathComponent(survey.uuid.uuidString).appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = survey.jsonData
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            var success = false
            
            if let error = error {
                print("Error creating dataTask \(error.localizedDescription) \(error)")
                completion(false) // TODO pass in success
                return
            }
            
            guard let data = data,
                let responseDataString = String(data: data, encoding: .utf8) else { completion(false); return }
            
            // This is for us the developer to see whats going on in our concol
            if let error = error {
                print("Error enconding: \(error.localizedDescription)")
            } else {
                print("Successfully saved data to endpoint. \nResponse: \(responseDataString)")
            }
            self.surveys.append(survey)
            success = true
            completion(success)
        }
        dataTask.resume()
    }
    
    // MARK: - Read 
    // The empty completion is a great way to notify the caller of the fuction that you are done running your code.
    static func fetchSurvesys(completion: @escaping () -> Void) {
        
        guard let url = baseURL?.appendingPathExtension("json") else {
            print("GaRrett borke our url")
            completion()
            return
        }
        
        // Create our data task
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                print("Error Fetching dataTask \(error.localizedDescription)")
                completion()
                return
            }
            
            guard let data = data else {
                print("No data returned from data task fetching")
                completion()
                return
            }
            
            // This is where we are drilling down
            guard let jsonDictioanry = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: [String: Any]] else {
                print("Fethinc from JsonObject")
                completion()
                return
            }
            
            let surveys = jsonDictioanry.flatMap { Survey(jsonDictionary: $0.value, identifier: $0.key)}
            
            self.surveys = surveys
            completion()
        }
        dataTask.resume()
        
    
    }
    
}
