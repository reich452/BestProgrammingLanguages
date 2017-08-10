//
//  SurveyListTableViewController.swift
//  BestProgrammingLanguanges
//
//  Created by Nick Reichard on 8/10/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class SurveyListTableViewController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        SurveyController.fetchSurvesys {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return SurveyController.surveys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SurveyCell", for: indexPath)
        
        let survey = SurveyController.surveys[indexPath.row]
        
        cell.textLabel?.text = survey.language
        cell.detailTextLabel?.text = survey.year
        
        return cell
    }

}
