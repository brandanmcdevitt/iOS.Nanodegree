//
//  StudentLocationsTableViewCell.swift
//  Project 04 On the Map
//
//  Created by Brandan McDevitt on 01/04/2020.
//  Copyright © 2020 Brandan McDevitt. All rights reserved.
//

import UIKit

class StudentLocationsTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mediaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
