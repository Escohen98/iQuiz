//
//  finished.swift
//  iQuiz
//
//  Created by Student User on 2/26/19.
//  Copyright © 2019 University of Washington. All rights reserved.
//

import UIKit
import SwiftyJSON

class finished: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let grade = quizObj.getScore()
        let textGrade = String(grade*100)
        score.text = "\(textGrade)%"
        let dT = "Your Grade:  "
        switch grade {
        case let g where g >= 0.9:
            descriptiveText.text = "\(dT)A!"
            break
        case let g where g >= 0.8:
            descriptiveText.text = "\(dT)B!"
            break
        case let g where g >= 0.7:
            descriptiveText.text = "\(dT)C."
            break
        case let g where g >= 0.6:
            descriptiveText.text = "\(dT)D.."
            break
        default:
            descriptiveText.text = "\(dT)F..."
            break
            
        }
        
    }
    @IBOutlet weak var descriptiveText: UILabel!
    @IBOutlet weak var score: UILabel!
    var quizObj : quiz = quiz(subject: "", questions: [JSON("")], description: "", icon: "")
}
