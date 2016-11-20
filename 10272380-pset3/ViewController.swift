//
//  ViewController.swift
//  10272380-pset3
//
//  Created by Quinten van der Post on 17/11/2016.
//  Copyright © 2016 Quinten van der Post. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController {
    
    var movieQuery = [JSON]()
    var watchList = [JSON]()
    var userList = [String]()

    @IBOutlet weak var movieYear: UITextField!
    @IBOutlet weak var movieTitle: UITextField!
    @IBOutlet weak var searchTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie finder"
        self.hideKeyboardWhenTappedAround()
        searchTable.rowHeight = 130
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    @IBAction func buttonToWatchList(_ sender: Any) {
        performSegue(withIdentifier: "segueToWatchList", sender: nil)
    }
    
    @IBAction func movieSearch(_ sender: Any) {
        if let title = movieTitle?.text! {
            if let year = movieYear?.text! {
                movieQuery.removeAll()
                let json = getMovieJson(name: title,year:  year)
                for i in 0...json["Search"].count {
                    if json["Search"][i] != JSON.null {
                        print(json["Search"][i])
                        movieQuery.append(json["Search"][i])
                    }
                }
                DispatchQueue.main.async {
                    self.searchTable.reloadData()
                }
                dismissKeyboard()
            }
        }
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
        let newYear = year.trimmingCharacters(in: NSCharacterSet(charactersIn: "0123456789").inverted)
        let defaults = UserDefaults.standard
        let url = URL(string: "https://www.omdbapi.com/?t=" + newTitle + "&y=" + newYear + "&plot=short&r=json")
        let data = try? Data(contentsOf: url!)
        let json = JSON(data: data!)
        userList = defaults.array(forKey: "watchList") as! [String]
        userList.append(json.rawString()!)
        defaults.set(userList, forKey: "watchList")
        defaults.synchronize()
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieQuery.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = searchTable.dequeueReusableCell(withIdentifier: "movieCell") as! movieSearchCell
        let json = movieQuery[indexPath.row]
        cell.movieImage.sd_setImage(with: URL(string: json["Poster"].stringValue), placeholderImage: UIImage(named: "Placeholder"))
        cell.movieTitle.text = json["Title"].stringValue
        cell.movieYear.text = json["Year"].stringValue
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let cellAction = UITableViewRowAction(style: .default, title: "Save") { (action, index) in
            let title = self.movieQuery[indexPath.row]["Title"].stringValue
            let year = self.movieQuery[indexPath.row]["Year"].stringValue
            self.updateUserdefaults(title: title, year: year)
            self.searchTable.reloadRows(at: [indexPath], with: .none)
            
            
        }
        cellAction.backgroundColor = UIColor.blue
        
        return [cellAction]
    }
    
    
}
