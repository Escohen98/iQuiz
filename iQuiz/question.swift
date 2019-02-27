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
        cell.button.setTitle(quizObj.getAnswers(index: quizObj.answered)[indexPath.item], for: .normal)
            cell.button.tag = indexPath.item
        print("Done")
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let qText = quizObj.getQuestion(index: quizObj.answered) as? [String]
        question.text = qText?[0]
        submit.isEnabled = false
        colView.delegate = self
        colView.dataSource = self
    }
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var submit: UIButton!
    
    var quizObj : quiz = quiz(subject: "", questions: [JSON("")], description: "", icon: "")
    
    @IBOutlet weak var colView: UICollectionView!
    private var selected = -1;
    @IBAction func setSelected(_ sender: UIButton) {
        selected = sender.tag
    }
    
}

class questionCell : UICollectionViewCell {
    @IBOutlet weak var button: UIButton!
    
}
