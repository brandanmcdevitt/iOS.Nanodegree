//
//  StudentAPI.swift
//  Project 04 On the Map
//
//  Created by Brandan McDevitt on 01/04/2020.
//  Copyright © 2020 Brandan McDevitt. All rights reserved.
//

import Foundation

class StudentAPI {
    let api = URL(string: "https://onthemap-api.udacity.com/v1/StudentLocation")
    let session = URLSession.shared
    
    func fetchStudents() {
        let request = URLRequest(url: api!)
        let task = session.dataTask(with: request) { data, response, error in
          if error != nil { // Handle error...
              return
          }
          print(String(data: data!, encoding: .utf8)!)
        }
        task.resume()
    }
    
    func postStudent() {
        var request = URLRequest(url: api!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.386052, \"longitude\": -122.083851}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
          if error != nil { // Handle error…
              return
          }
          print(String(data: data!, encoding: .utf8)!)
        }
        task.resume()
    }
    
    /*
     
     Required Parameters:
     objectId - (String) the object ID of the StudentLocation to update; specify the object ID right after StudentLocation in URL as seen below
     Example: https://onthemap-api.udacity.com/v1/StudentLocation/8ZExGR5uX8
     
     */
    
    func updateStudent() {
        let url = api?.appendingPathComponent("/8ZExGR5uX8")
        var request = URLRequest(url: url!)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Cupertino, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.322998, \"longitude\": -122.032182}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
          if error != nil { // Handle error…
              return
          }
          print(String(data: data!, encoding: .utf8)!)
        }
        task.resume()
    }
}
