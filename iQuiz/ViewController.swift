//
//  ViewController.swift
//  iQuiz
//
//  Created by Student User on 2/14/19.
//  Copyright © 2019 University of Washington. All rights reserved.
//

import UIKit
import Alamo

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
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func settings(_ btn: UIBarButtonItem!) {
        let alert = UIAlertController(title: "Settings", message: "go here.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    var quizzes : Array<(String, Dictionary<String, [String]>)>
    //Taken from https://stackoverflow.com/questions/26364914/http-request-in-swift-with-post-method/26365148
    let url = "https://api.myjson.com/bins/19qiyy"
    func fetchData() {
    
        // Set the URL the request is being made to.
        let request = URLRequest(url: NSURL(string: url)! as URL)
        do {
            // Perform the request
            var response: AutoreleasingUnsafeMutablePointer<URLResponse?>? = nil
            let data = try NSURLConnection.sendSynchronousRequest(request, returning: response)
    
            // Convert the data to JSON
            let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
    
            if let json = jsonSerialized, let url = json["url"], let explanation = json["explanation"] {
                print(url)
                print(explanation)
            }
        }
    }
}

class QuizCell: UITableViewCell {
    @IBOutlet weak var title: UILabel! //30 char limit
    @IBOutlet weak var desc: UILabel! //Description; Short Sentence
    @IBOutlet weak var icon: UIImageView! //Image to represent quiz
    
    
    
    
}
