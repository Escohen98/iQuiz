//
//  ViewController.swift
//  iQuiz
//
//  Created by Student User on 2/14/19.
//  Copyright © 2019 University of Washington. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    let quizzes: [String] = ["Mathematics", "Marvel Super Heroes", "Science"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
}
/*
protocol quizRepository {
    func getNumber() -> UInt
    func getQuestions -> [String]
    func saveAnswers
}
*/

class QuizCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    var icon: UIImage! = nil //Image to represent quiz
    var subject: String = ""; //Title 30 char limit
    var desc: String = ""; //Description; Short Sentence
    
    
    
    
}
