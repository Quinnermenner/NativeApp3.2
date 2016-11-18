//
//  WatchListViewViewController.swift
//  10272380-pset3
//
//  Created by Quinten van der Post on 18/11/2016.
//  Copyright © 2016 Quinten van der Post. All rights reserved.
//

import UIKit
import SwiftyJSON

class WatchListViewViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movieList = [JSON]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        if let defaultsMovieList = defaults.object(forKey: "watchList") {
            movieList = defaultsMovieList as! [JSON]
        }
        print(movieList)
        
        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView(tableView, willDisplay: watchListCell, forRowAt: IndexPath) {
//            tableView.estimatedRowHeight = UITableViewAutomaticDimension

//        }
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension WatchListViewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let json = movieList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "watchListCell") as! movieCustomCell
        cell.movieYear.text = json["Year"].string
        cell.movieDirector.text =  json["Director"].string
        cell.movieCast.text = json["Cast"].string
        cell.movieDescription.text = json["Plot"].string
        cell.movieMetascore.text = json["Metascore"].string
        cell.movieIMDB.text = json["imdbRating"].string
        
        return cell
    }
    
    
    
    
}
