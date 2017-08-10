//
//  SuveyViewController.swift
//  BestProgrammingLanguanges
//
//  Created by Nick Reichard on 8/10/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class SuveyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    // MARK: - Actions 
    @IBAction func submittButtonTapped(_ sender: Any) {
        guard let language = languageTextField.text, language != "",
            let year = yearTextField.text, year != "" else { return }
        
        SurveyController.putSurveyWith(language: language, year: year) { (success) in
            
            guard success else { return }
            
            DispatchQueue.main.async {
                self.languageTextField.text = ""
                self.yearTextField.text = ""
            }
        }
    }

    @IBOutlet weak var languageTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    
}
