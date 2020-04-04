//
//  UserAPI.swift
//  Project 04 On the Map
//
//  Created by Brandan McDevitt on 01/04/2020.
//  Copyright © 2020 Brandan McDevitt. All rights reserved.
//

import Foundation

class UserAPI {
    
    let api = URL(string: "https://onthemap-api.udacity.com/v1/users")
    
    func fetchUsers() {
        let url = api?.appendingPathComponent("/3903878747")
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
          if error != nil { // Handle error...
              return
          }
          let range = 5 ..< data!.count
          let newData = data?.subdata(in: range) /* subset response data! */
          print(String(data: newData!, encoding: .utf8)!)
        }
        task.resume()
    }
}
