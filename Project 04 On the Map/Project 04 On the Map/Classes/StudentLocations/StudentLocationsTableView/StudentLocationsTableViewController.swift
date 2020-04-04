//
//  StudentLocationsTableViewController.swift
//  Project 04 On the Map
//
//  Created by Brandan McDevitt on 01/04/2020.
//  Copyright © 2020 Brandan McDevitt. All rights reserved.
//

import UIKit

class StudentLocationsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StudentLocationsTableViewCell

        return cell
    }
}
