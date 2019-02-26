//
//  quiz.swift
//  iQuiz
//
//  Created by Student User on 2/19/19.
//  Copyright © 2019 University of Washington. All rights reserved.
//

import UIKit

//scores is the only mutable object declared in class. Everything else is read-only after initialize.
class quiz {
    
    /*
    * Initializes a quiz object.
    * @param Subject (String) - Quiz Topic
    * @param questions (NSDictionary<String, Array<String>) - A dictionary containing all of the questions
    * and an array of the answers for each question.
    */
    init(subject: String, questions: Dictionary<String, Dictionary<String, [String]>>, description: String, icon: String) {
        self.subject = subject
        self.questions = questions //NSDictionary<String, Array<String>>
        self.description = description
        self.icon = icon
        QCOUNT = questions.count
        resetAnswers()
    }
    
    private let QCOUNT : Int //Number of questions.
    private let subject : String
    private let questions : Dictionary<String, Dictionary<String, [String]>> //Contains all questions/answer pairs (String/Array<String>)
    private var correct = 0 //Contains booleans of whether a user got the question correct or not.
    private let description: String
    private let icon: String
    
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
        let keys = Array(questions.keys)
        if(index == -1) {
            return keys
        } else if index > QCOUNT-1 || index < 0 {
            return []
        }
        return [keys[index]]
    }
    
    /*
     * Takes in a key string and returns the corresponding value pair if exists.
     * Otherwise returns an empty array.
     */
    func getAnswers(key: String) -> Any {
        if((questions[key]) != nil) {
            return questions[key]!
        }
        return []
    }
    
    /*
     * Adds 1 to correct if answer is correct, returns true
     * Returns false if answer is incorrect
     */
    func setCorrect(question: String, answer: String) -> Bool {
        if(isCorrect(question, answer)) {
            correct += 1
            return true
        }
        return false
        
    }
    
    /*
     * Checks if given answer is correct one for the given answer.
     * Uses index value in tuple to check. Returns true if yes, false otherwise. 
     */
    func isCorrect(_ question: String, _ answer: String) -> Bool {
        let qstn = questions[question]
        if 	qstn!["answer"]!.index(of: answer) == Int(qstn!["correct"]![0]) {
            return true
        }
        return false
    }
    
    //Sets correct answers to 0.
    func resetAnswers() {
        correct = 0
    }
    
}

protocol QuizRepository {
    func getTopics() -> [quiz]
    func saveQuiz(data: [quiz]) -> Bool
    func findQuizByTopic(_ topic: String) -> [quiz]
}
