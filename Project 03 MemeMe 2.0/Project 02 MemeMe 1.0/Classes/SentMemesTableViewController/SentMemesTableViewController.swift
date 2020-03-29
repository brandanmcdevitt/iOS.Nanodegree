//
//  SentMemesTableViewController.swift
//  Project 02 MemeMe 1.0
//
//  Created by Brandan McDevitt on 29/03/2020.
//  Copyright © 2020 Brandan McDevitt. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    
    private let reuseIdentifier = "Cell"
    private let notificationName = Notification.Name("SentMeme")
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: notificationName, object: nil)
    }
    
    @objc func reload() {
         tableView.reloadData()
     }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SentMemesTableViewCell
        
        cell.memeImage?.image = memes[indexPath.row].memeImage
        cell.memeText?.text = "\(memes[indexPath.row].topText)...\(memes[indexPath.row].bottomText)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
}
