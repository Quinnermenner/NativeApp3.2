//
//  ViewController.swift
//  10272380-pset3
//
//  Created by Quinten van der Post on 17/11/2016.
//  Copyright © 2016 Quinten van der Post. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    
    var movieQuery = [JSON]()

    @IBOutlet weak var movieYear: UITextField!
    @IBOutlet weak var movieTitle: UITextField!
    @IBOutlet weak var searchTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationController?.navigationItem.title = "Watch List"
        
    }
    
    
    @IBAction func showWatchList(_ sender: Any) {
        shouldPerformSegue(withIdentifier: "segueToWatchList", sender: self)
    }
    
    
    @IBAction func movieSearch(_ sender: Any) {
        if let title = movieTitle?.text! {
            if let year = movieYear?.text! {
                movieQuery.removeAll()
                let json = getMovieJson(name: title,year:  year)
                for i in 0...json["Search"].count {
                    movieQuery.append(json["Search"][i])
                }
                DispatchQueue.main.async {
                    self.searchTable.reloadData()
                }
            }
        }
        print(movieQuery[0]["Title"].string ?? "No title found.")
    }
    
    
    func getMovieJson(name: String, year: String) -> JSON {
        let url = URL(string: "https://www.omdbapi.com/?s=" + name + "&y=" + year + "&plot=short&r=json")
        let data = try? Data(contentsOf: url!)
        let json = JSON(data: data!)
        return json
    }
    
    
    


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieQuery.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        title = movieQuery[indexPath.row]["Title"].string
        let cell = searchTable.dequeueReusableCell(withIdentifier: "movieCell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "movieCell")
        cell.textLabel?.text = title
        
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let cellAction = UITableViewRowAction(style: .normal, title: "Save") { (action, index) in
            
            // TODO: Save IMDB ID -> [String]()
            
        }
        cellAction.backgroundColor = UIColor.blue
        
        return [cellAction]
        
        
    }
    
    
}
