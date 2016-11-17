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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    
    @IBAction func movieSearch(_ sender: Any) {
        if let title = movieTitle?.text! {
            if let year = movieYear?.text! {
                movieQuery.removeAll()
                let json = getMovieJson(name: title,year:  year)
                for i in 0...json["Search"].count {
                    movieQuery.append(json["Search"][i])
                }
            }
        }
        print(movieQuery)
    }
    
    
    func getMovieJson(name: String, year: String) -> JSON {
        let url = URL(string: "https://www.omdbapi.com/?s=" + name + "&y=" + year + "&plot=short&r=json")
        let data = try? Data(contentsOf: url!)
        let json = JSON(data: data!)
        return json
    }
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

