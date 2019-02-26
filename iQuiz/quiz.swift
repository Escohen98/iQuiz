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
    init(subject: String, questions: [String: ([String], Int)]/*, correct: Array<Int>*/) {
        self.subject = subject
        self.questions = questions //NSDictionary<String, Array<String>>
        //Need to figure out how to import an NSDictionary<String, Array<[String], Bool>> explicitly. Necessary for the getQuestion, getAnswer, and setCorrect functions.
        //self.correct = correct
        QCOUNT = questions.count
        resetAnswers()
    }
    
    private let QCOUNT : Int //Number of questions.
    private var subject : String = ""
    private var questions : [String: ([String], Int)] //Contains all questions/answer pairs (String/Array<String>)
    private var scores : Array<Bool> = Array<Bool>() //Contains booleans of whether a user got the question correct or not.
    //private var correct : Array<Int> //Array of indexes of the correct answer for each question.
    
    //Returns the subject
    func getSubject() -> String {
        return subject
    }
    
    //Returns the number of questions.
    func getQuestionCount() -> Int {
        return QCOUNT
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
     * Sets the element at the given index in scores to true. Returns element
     * Returns false if index does not exist.
     */
    func setCorrect(question: String, answer: String) -> Bool {
        let index = Array(questions.keys).index(of: question) as! Int
        if(isCorrect(question, answer)) {
            scores[index] = true
            return scores[index]
        }
        return false
        
    }
    
    /*
     * Checks if given answer is correct one for the given answer.
     * Uses index value in tuple to check. Returns true if yes, false otherwise. 
     */
    func isCorrect(_ question: String, _ answer: String) -> Bool {
        let qstn = questions[question]
        if 	qstn!.0.index(of: answer) == qstn!.1 {
            return true
        }
        return false
    }
    
    //Sets all scores array to array of false of size QCOUNT.
    func resetAnswers() {
        for _ in 1...QCOUNT {
            scores.append(false)
        }
    }
    
}

protocol QuizRepository {
    func getTopics() -> [quiz]
    func saveQuiz(data: [quiz]) -> Bool
    func findQuizByTopic(_ topic: String) -> [quiz]
}
