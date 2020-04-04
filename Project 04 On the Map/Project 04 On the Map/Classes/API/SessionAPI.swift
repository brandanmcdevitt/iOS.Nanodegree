//
//  SessionAPI.swift
//  Project 04 On the Map
//
//  Created by Brandan McDevitt on 01/04/2020.
//  Copyright © 2020 Brandan McDevitt. All rights reserved.
//

import Foundation

class SessionAPI {
    
    enum LoginError: Error {
        case noConnection
        case incorrectCredentials
        
        var description: String {
            switch self {
            case .noConnection:
                return "Unable to connect. Please check your internet connection and try again."
            case .incorrectCredentials:
                return "Incorrect email/password."
            }
        }
    }

    let api = URL(string: "https://onthemap-api.udacity.com/v1/session")
    
    func postSession(username: String, password: String, completion: @escaping (Result<Session, LoginError>) -> Void) {
        var request = URLRequest(url: api!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // encoding a JSON body from a string, can also use a Codable struct
        request.httpBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                do {
                    if let data = data {
                        let range = 5 ..< data.count
                        let newData = data.subdata(in: range)
                        
                        let jsonDecoder = JSONDecoder()
                        let response = try jsonDecoder.decode(Session.self, from: newData)
                        completion(.success(response))
                    } else {
                        completion(.failure(.noConnection))
                    }
                } catch {
                    completion(.failure(.incorrectCredentials))
                }
            }
        }
        task.resume()
    }
    
    func deleteSession() {
        var request = URLRequest(url: api!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
          if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
          request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
          if error != nil { // Handle error…
              return
          }
          let range = 5 ..< data!.count
          let newData = data?.subdata(in: range) /* subset response data! */
          print(String(data: newData!, encoding: .utf8)!)
        }
        task.resume()
    }
}
