//
//  MemeDetailViewController.swift
//  Project 02 MemeMe 1.0
//
//  Created by Brandan McDevitt on 30/03/2020.
//  Copyright © 2020 Brandan McDevitt. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    @IBOutlet weak var memeImage: UIImageView!
    var meme: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memeImage.image = meme
    }
}
