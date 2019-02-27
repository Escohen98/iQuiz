//
//  questionViewController.swift
//  iQuiz
//
//  Created by Student User on 2/26/19.
//  Copyright © 2019 University of Washington. All rights reserved.
//

import UIKit
import SwiftyJSON

class question: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "questcell", for: indexPath) as! questionCell
        cell.tag = indexPath.item
        cell.label.text = quizObj.getAnswers(index: quizObj.answered)[indexPath.item]
        print("Done")
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let qText = quizObj.getQuestion(index: quizObj.answered) as? [String]
        question.text = qText?[0]
        colView.delegate = self
        colView.dataSource = self
    }
    @IBOutlet weak var question: UILabel!
    
    var quizObj : quiz = quiz(subject: "", questions: [JSON("")], description: "", icon: "")
    
    @IBOutlet weak var colView: UICollectionView!
    
}

class questionCell : UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
}
