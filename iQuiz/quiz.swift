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
    init(subject: String, questions: NSDictionary) {
        self.subject = subject
        self.questions = questions
        QCOUNT = questions.count
        resetAnswers()
    }
    
    private let QCOUNT : Int //Number of questions.
    private var subject : String = ""
    private var questions : NSDictionary //Contains all questions/answer pairs (String/Array<String>)
    private var scores : Array<Bool> = Array<Bool>() //Contains booleans of whether a user got the question correct or not.
    
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
        let keys = questions.allKeys
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
    func setCorrect(index: Int) -> Bool {
        if(index >= 0 && index < QCOUNT) {
            scores[index] = true
            return scores[index]
        }
        return false
        /*
         * Change function to check if answer is correct.
         * Make an array or add to dictionary the correct answer (as an index value)
         * sets true if correct answer
         */
    }
    
    //Sets all scores array to array of false of size QCOUNT.
    func resetAnswers() {
        for _ in 1...QCOUNT {
            scores.append(false)
        }
    }
    
}
