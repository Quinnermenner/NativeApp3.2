//
//  movieSearchCell.swift
//  10272380-pset3
//
//  Created by Quinten van der Post on 20/11/2016.
//  Copyright © 2016 Quinten van der Post. All rights reserved.
//

import UIKit

class movieSearchCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
