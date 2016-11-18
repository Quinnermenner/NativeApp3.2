//
//  movieCustomCell.swift
//  10272380-pset3
//
//  Created by Quinten van der Post on 18/11/2016.
//  Copyright © 2016 Quinten van der Post. All rights reserved.
//

import UIKit

class movieCustomCell: UITableViewCell {

    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
