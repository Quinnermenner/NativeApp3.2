//
//  WatchListViewViewController.swift
//  10272380-pset3
//
//  Created by Quinten van der Post on 18/11/2016.
//  Copyright © 2016 Quinten van der Post. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage

class WatchListViewViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movieList = [JSON]()
    var userList = [String]()
    var placeholderImage = UIImage(named: "Placeholder")
    var selectedIndexPath: IndexPath?
    var extraHeight: CGFloat = 100

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Your watch list!"
        let defaults = UserDefaults.standard
        userList = defaults.array(forKey: "watchList") as! [String]
        for value in defaults.array(forKey: "watchList")! {
            let json = JSON.parse(value as! String)
            movieList.append(json)
        }

        // Do any additional setup after loading the view.
    }
    

}

extension WatchListViewViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let json = movieList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "watchListCell") as! movieCustomCell
        cell.movieYear.text = json["Year"].stringValue
        cell.movieDirector.text =  json["Director"].stringValue
        cell.movieDescription.text = json["Plot"].stringValue
        cell.movieMetascore.text = json["Metascore"].stringValue
        cell.movieIMDB.text = json["imdbRating"].stringValue
        cell.movieImage.sd_setImage(with: URL(string: json["Poster"].stringValue), placeholderImage: placeholderImage)
        cell.movieTitle.text = json["Title"].stringValue
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let cellAction = UITableViewRowAction(style: .default, title: "Remove") { (action, index) in

            self.userList.remove(at: indexPath.row)
            self.movieList.remove(at: indexPath.row)
            let defaults = UserDefaults.standard
            defaults.set(self.userList, forKey: "watchList")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        cellAction.backgroundColor = UIColor.blue
        
        return [cellAction]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedIndexPath == indexPath {
            return 135 + extraHeight
        }
        
        return 135.0
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        let currentCell = tableView.cellForRow(at: selectedIndexPath!) as! movieCustomCell
        if currentCell.expanded == false {
            currentCell.movieDescription.sizeToFit()
            extraHeight = currentCell.movieDescription.frame.height + 20
            currentCell.expanded = true
        }
        else {
            extraHeight = 0
            currentCell.expanded = false
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    
}
