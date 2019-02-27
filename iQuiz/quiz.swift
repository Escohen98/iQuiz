//
//  quiz.swift
//  iQuiz
//
//  Created by Student User on 2/19/19.
//  Copyright © 2019 University of Washington. All rights reserved.
//

import UIKit
import SwiftyJSON

//scores is the only mutable object declared in class. Everything else is read-only after initialize.
class quiz {
    
    /*
    * Initializes a quiz object.
    * @param Subject (String) - Quiz Topic
    * @param questions (NSDictionary<String, Array<String>) - A dictionary containing all of the questions
    * and an array of the answers for each question.
    */
    init(subject: String, questions: [JSON], description: String, icon: String) {
        self.subject = subject
        self.questions = questions //NSDictionary<String, Array<String>>
        self.description = description
        self.icon = icon
        QCOUNT = questions.count
        resetAnswers()
    }
    
    private let QCOUNT : Int //Number of questions.
    private let subject : String //Title
    private let questions : [JSON] //Contains all questions/answer pairs (String/Array<String>)
    private var correct = 0 //Number of questions answered correctly
    private let description: String
    private let icon: String
    var answered = 0 //Number of questions answered
    
    //Returns the subject
    func getSubject() -> String {
        return subject
    }
    
    //Returns the number of questions.
    func getQuestionCount() -> Int {
        return QCOUNT
    }
    
    func getDescription() -> String {
        return description
    }
    
    func getIcon() -> String {
        return icon
    }
    
    /*
     * Returns an array with 1 question if the index is provided and is within range.
     * Returns an empty array if index is not in range
     * Returns an array of all of the questions.
     */
    func getQuestion(index: Int = -1) -> [Any] {
        var keys : Array<String> = []
        for qs in questions {
            keys.append(qs["text"].stringValue)
        }
        if(index == -1) {
            return keys
        } else if index > QCOUNT-1 || index < 0 {
            return []
        }
        return [keys[index]]
    }
    
    /*
     * Takes an index and returns the answers for the given index.
     * Otherwise returns an empty array.
     */
    func getAnswers(index: Int) -> Array<String> {
        var answers : Array<String> = []
        let array = questions[index]["answers"].arrayValue
        for ans : JSON in array {
            answers.append(ans.stringValue)
        }
            return answers
    }
    
    /*
     * Adds 1 to correct if answer is correct, returns true
     * Returns false if answer is incorrect
     */
    func setCorrect(index: Int, answer: String) -> Bool {
        if(isCorrect(index, answer)) {
            correct += 1
            return true
        }
        return false
        
    }
    
    /*
     * Checks if given answer is correct one for the given answer.
     * Uses index value in tuple to check. Returns true if yes, false otherwise. 
     */
    func isCorrect(_ index: Int, _ answer: String) -> Bool {
        
        if getCorrect(index) == answer {
                return true
        }
        return false
    }
    
    //Returns the correct answer for the given question
    func getCorrect(_ index: Int) -> String {
        let ans = getAnswers(index: index)
        let correct = questions[index]["answer"].stringValue
        return ans[Int(correct)!]
    }
    
    //Sets correct answers and answered questions to 0.
    func resetAnswers() {
        correct = 0
        answered = 0
    }
    
    //Returns the current score
    func getScore() -> Double {
        return Double(correct)/Double(answered)
    }
    
    //Checks if user has answered all of the questions for the given quiz. Returns true if finished. False otherwise.
    func finished() -> Bool {
        if(answered == QCOUNT) {
            return true
        }
        return false
    }
    
}
