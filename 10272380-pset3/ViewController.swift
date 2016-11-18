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
    var watchList = [JSON]()

    @IBOutlet weak var movieYear: UITextField!
    @IBOutlet weak var movieTitle: UITextField!
    @IBOutlet weak var searchTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        let defaults = UserDefaults.standard
        if let defaultsMovieList = defaults.object(forKey: "watchList") {
            watchList = defaultsMovieList as! [JSON]
        }
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationController?.navigationItem.title = "Watch List"
        
    }
    
    @IBAction func buttonToWatchList(_ sender: Any) {
        performSegue(withIdentifier: "segueToWatchList", sender: nil)
        print("tap")
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
        let newName = name.replacingOccurrences(of: " ", with: "+")
        let url = URL(string: "https://www.omdbapi.com/?s=" + newName + "&y=" + year + "&plot=short&r=json")
        let data = try? Data(contentsOf: url!)
        let json = JSON(data: data!)
        return json
    }
    
    func updateUserdefaults(title: String, year: String) {
        let newTitle = title.replacingOccurrences(of: " ", with: "+")
        let defaults = UserDefaults.standard
        let url = URL(string: "https://www.omdbapi.com/?t=" + newTitle + "&y=" + year + "&plot=short&r=json")
        let data = try? Data(contentsOf: url!)
        let json = JSON(data: data!)
        watchList.append(json)
        defaults.set(watchList, forKey: "watchList")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let watchListVC = segue.destination as? WatchListViewViewController {
            watchListVC.movieList = movieQuery
        }
    }
    


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieQuery.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let json = movieQuery[indexPath.row]
        let cell = searchTable.dequeueReusableCell(withIdentifier: "movieCell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "movieCell")
        cell.textLabel?.text = json["Title"].string
        cell.detailTextLabel?.text = json["Year"].string
        
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let cellAction = UITableViewRowAction(style: .normal, title: "Save") { (action, index) in
            
            // TODO: Save IMDB ID -> [String]()
            let title = self.movieQuery[indexPath.row]["Title"].string
            let year = self.movieQuery[indexPath.row]["Year"].string
            self.updateUserdefaults(title: title!, year: year!)
            
            
        }
        cellAction.backgroundColor = UIColor.blue
        
        return [cellAction]
        
        
    }
    
    
}
