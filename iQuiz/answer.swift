//
//  answer.swift
//  iQuiz
//
//  Created by Student User on 2/26/19.
//  Copyright © 2019 University of Washington. All rights reserved.
//

import UIKit
import SwiftyJSON

class Answer: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueOn.isHidden = true
        if(quizObj.getQuestionCount() == quizObj.answered) {
            results.isHidden = false
            continueOn.isHidden = true
        }
        answer.text = answerImport
        question.text = questionImport
        self.view.backgroundColor = backgroundColor
    }
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var results: UIButton!
    @IBOutlet weak var continueOn: UIButton!
    
    var quizObj : quiz = quiz(subject: "", questions: [JSON("")], description: "", icon: "")
    var backgroundColor = UIColor.red
    var answerImport = ""
    var questionImport = ""
    
    
    //Updates score and sneds data to answer class.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "continue") {
            let questionVC = segue.destination as! question
            questionVC.quizObj = quizObj
        } else if segue.identifier == "results" {
            let finishedVC = segue.destination as! finished
            finishedVC.quizObj = quizObj
        }
    }
}
