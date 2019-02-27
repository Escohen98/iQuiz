//
//  resultsViewController.swift
//  iQuiz
//
//  Created by Eric S. Cohen on 2/26/19.
//  Copyright © 2019 University of Washington. All rights reserved.
//

import UIKit
import SwiftyJSON

class results: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    var quizObj : quiz = quiz(subject: "", questions: [JSON("")], description: "", icon: "")

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
