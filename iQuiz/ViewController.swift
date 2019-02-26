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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //https://api.myjson.com/bins/19qiyy
    @IBOutlet weak var tableView: UITableView!
    
    let titles: [String] = ["Mathematics", "Marvel Super Heroes", "Science"]
    
    let descriptions: [String] = ["Test your math skills!", "Woh, Superheroes!", "What's an atom?"]
    let icons: [String] = ["images/math_ico.jpg", "images/marvel_ico.png", "images/science_ico.jpg"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "qcell", for: indexPath) as! QuizCell
        let str = titles[indexPath.item]
        
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
        print("Cell Initialized")
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchData()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func settings(_ btn: UIBarButtonItem!) {
        let alert = UIAlertController(title: "Settings", message: "go here.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    var quizzes : Dictionary<String, Dictionary<String, Dictionary<String, Any>>>
    //Taken from https://nearsoft.com/blog/how-to-get-started-with-alamofire/
    let url = "https://api.myjson.com/bins/19qiyy"
    //[String: [String: [String: [[String], [String: Int]]]]
    // Topic,   Question, answer,  Answers,  correct, Index
   func fetchData() {
    Alamofire.request(url).responseJSON { response in
        if let jsonObj = response.result.value as? Dictionary<String, Dictionary<String, Dictionary<String, Any>>> {
            
            //print("JSON: \(jsonObj)") // serialized json response
            //self.saveJSON(json: jsonObj)
            //self.findContact()
        }
    }
    }
    
    let managedObjectContext = (UIApplication.shared.delegate
        as! AppDelegate).persistentContainer.viewContext
    //Taken from https://www.techotopia.com/index.php/An_iOS_8_Swift_Core_Data_Tutorial
    func saveJSON(json: NSDictionary) {
        let entityDescription =
            NSEntityDescription.entity(forEntityName: "JsonDict",
                                       in: managedObjectContext)
        
        let contact = JsonDict(entity: entityDescription!,
                               insertInto: managedObjectContext)
        
        contact.json = json
        
        do {
            try managedObjectContext.save()
            //Actions after saving
            
        } catch let error {
            print(error.localizedDescription)
        }
    }

    func findContact() {
        let entityDescription =
            NSEntityDescription.entity(forEntityName: "JsonDict",
                                       in: managedObjectContext)
        
        let request: NSFetchRequest<JsonDict> = JsonDict.fetchRequest()
        request.entity = entityDescription
        
        //let pred = NSPredicate(format: "(name = %@)", name.text!)
        //request.predicate = pred
        
        do {
            var results =
                try managedObjectContext.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>)
            
            if results.count > 0 {
                let match = results[0] as! NSManagedObject
                print(match)
            } else {
                print("No Match")
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    //[String: [String: [String: [[String], [String: Int]]]]
    // Topic,   Question, answer,  Answers,  correct, Index
    var qzzs : Array<quiz>
    func setQuizzes(json: Dictionary<String, Dictionary<String, Dictionary<String, Any>>>) {
        for topic in json.keys {
            let qstns = json[topic]
            qzzs.append(quiz(subject: topic, questions: qstns!))
        }
    }
}
class QuizCell: UITableViewCell {
    @IBOutlet weak var title: UILabel! //30 char limit
    @IBOutlet weak var desc: UILabel! //Description; Short Sentence
    @IBOutlet weak var icon: UIImageView! //Image to represent quiz
    
    
    
    
}
