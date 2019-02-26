//
//  options.swift
//  iQuiz
//
//  Created by Student User on 2/26/19.
//  Copyright © 2019 University of Washington. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class options: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        baseURL = url.text ?? ""
        // Do any additional setup after loading the view.
    }
    let savedJSON = UserDefaults.standard.string(forKey: "downloadedJSON")
    var baseURL : String = ""
    @IBOutlet weak var url: UITextField!
    @IBAction func fetchData(_ sender: Any) {
        DownloadJSON(url: baseURL)
    }
    
    func DownloadJSON(url: String){
        
        Alamofire.request(url).responseJSON{response in
            if response.result.value != nil {
                let data = JSON(response.result.value as Any)
                
                for items in data{
                    print(items)
                }
                
                //We got the data, now we'll save the data in its state as a String
                UserDefaults.standard.set(data.rawString(), forKey: "downloadedJSON")
                //now that we saved we can parse this inforamtion into another function
            }
            else {
                let alert = UIAlertController(title: "Download Failed.", message: "Please try again later.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)

            }
            
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}