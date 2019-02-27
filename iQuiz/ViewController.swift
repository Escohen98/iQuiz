//
//  ViewController.swift
//  iQuiz
//
//  Created by Student User on 2/14/19.
//  Copyright © 2019 University of Washington. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //https://api.myjson.com/bins/19qiyy
    @IBOutlet weak var tableView: UITableView!
    
    let titles: [String] = ["Mathematics", "Marvel Super Heroes", "Science"]
    
    let descriptions: [String] = ["Test your math skills!", "Woh, Superheroes!", "What's an atom?"]
    let icons: [String] = ["images/math_ico.jpg", "images/marvel_ico.png", "images/science_ico.jpg"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qzzs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "qcell", for: indexPath) as! QuizCell
        let str = qzzs[indexPath.item].getSubject()
        print(str)
        //Takes first 30 characters of a string
        //Because substrings are so unnecessarily complicated.
        if(str.count > 30) {
            let start = str.index(str.startIndex, offsetBy: 0)
            let end = str.index(str.endIndex, offsetBy: 30  )
            let range = start..<end
            cell.title.text = String(str[range])
        } else {
            cell.title.text = str
        }
        cell.desc.text = qzzs[indexPath.item].getDescription()
        cell.imageView?.image = UIImage(named: qzzs[indexPath.item].getIcon())
        cell.tag = indexPath.item
        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        isSaved()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //Taken from https://nearsoft.com/blog/how-to-get-started-with-alamofire/
    //let url = "https://api.myjson.com/bins/c2gpm"
    let url = "http://tednewardsandbox.site44.com/questions.json"
    let savedJSON = UserDefaults.standard.string(forKey: "downloadedJSON")
    //Checks if there's a JSON saved. If yes, Creates quiz objects. Otherwise, downloads JSON then creates quiz objects.
    var flag = false
    func isSaved() {
        //Checks if the user has a saved JSON file in their storage, if not will download
        if savedJSON != nil{
            print("User has a saved JSON")
            //convert our json if not already
            
            let data = JSON.init(parseJSON: savedJSON!)
            
            setQuizzes(json: data)
            
            
        }else{
            print("No JSON Found")
            options().download(url, self)
            if !flag {
                flag = true
                isSaved()
            } else {
                let alert = UIAlertController(title: "Something went wrong.", message: "Please download quiz in the Settings.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    //[String: [String: [String: [[String], [String: Int]]]]
    // Topic,   Question, answer,  Answers,  correct, Index
    var qzzs : Array<quiz> = []
    //Creates quiz objects and buts them into qzzs array.   
    func setQuizzes(json: JSON) {
        var i = 0
        for (key, innerJSON) : (String, JSON) in json {
            let q = innerJSON["questions"].arrayValue
            let desc = innerJSON["desc"].stringValue
            let title = innerJSON["title"].stringValue
            print(title)
            qzzs.append(quiz(subject: title, questions: q, description: desc, icon: icons[i%3]))
            i += 1
            
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    //Sends quiz object to questionVC.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "quizSelect") {
            let questionVC = segue.destination as! question
            let newSender = sender as? UITableViewCell
            questionVC.quizObj = qzzs[newSender!.tag]
        }
    }
    
}
class QuizCell: UITableViewCell {
    @IBOutlet weak var title: UILabel! //30 char limit
    @IBOutlet weak var desc: UILabel! //Description; Short Sentence
    @IBOutlet weak var icon: UIImageView! //Image to represent quiz
    
}
