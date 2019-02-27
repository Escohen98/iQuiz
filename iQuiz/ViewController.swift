//
//  ViewController.swift
//  iQuiz
//
//  Created by Student User on 2/14/19.
//  Copyright © 2019 University of Washington. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //https://api.myjson.com/bins/19qiyy
    @IBOutlet weak var tableView: UITableView!
    
    var titles: [String] = ["Math", "Science", "History", "Countries"]
    
    let descriptions: [String] = ["Test your math skills!", "What's an atom?", "Visit the Moonlanding Set!", "Countries can be big."]
    let icons: [String] = ["images/math_ico.jpg", "images/science_ico.jpg", "images/history_ico.jpg", "images/country_ico.jpeg"]
    let options : options = options()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return descriptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "qcell", for: indexPath) as! QuizCell
        print("indexPath: \(indexPath.item)")
        print("qzzs length: \(qzzs.count)")
        let str = titles[indexPath.item]
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
        cell.desc.text = descriptions[indexPath.item]
        cell.imageView?.image = UIImage(named: icons[indexPath.item])
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //Taken from https://nearsoft.com/blog/how-to-get-started-with-alamofire/
    let url = "https://api.myjson.com/bins/c2gpm"
    let savedJSON = UserDefaults.standard.string(forKey: "downloadedJSON")
    func isSaved() {
        //Checks if the user has a saved JSON file in their storage, if not will download
        if savedJSON != nil{
            print("User has a saved JSON")
            //convert our json if not already
            
            let data = JSON.init(parseJSON: savedJSON!)
            
            ParseJSON(json: data)
            
        }else{
            print("No JSON Found")
            options.DownloadJSON(url: url)

    }
    
    //[String: [String: [String: [[String], [String: Int]]]]
    // Topic,   Question, answer,  Answers,  correct, Index
    var qzzs : Array<quiz> = []
    //Creates quiz objects and buts them into qzzs array.   
    func setQuizzes(json: JSON) {
        var i = 0
        for (key, innerJSON) : (String, JSON) in json {
            qzzs.append(quiz(subject: key, questions: innerJSON, description: descriptions[i], icon: icons[i]))
            i += 1
            
        }
    }
    
}
class QuizCell: UITableViewCell {
    @IBOutlet weak var title: UILabel! //30 char limit
    @IBOutlet weak var desc: UILabel! //Description; Short Sentence
    @IBOutlet weak var icon: UIImageView! //Image to represent quiz
    
    
    
    
}
