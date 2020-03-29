//
//  SentMemesTableViewCell.swift
//  Project 02 MemeMe 1.0
//
//  Created by Brandan McDevitt on 29/03/2020.
//  Copyright © 2020 Brandan McDevitt. All rights reserved.
//

import UIKit

class SentMemesTableViewCell: UITableViewCell {
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var memeText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
