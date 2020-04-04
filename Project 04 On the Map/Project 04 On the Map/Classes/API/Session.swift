//
//  Session.swift
//  Project 04 On the Map
//
//  Created by Brandan McDevitt on 01/04/2020.
//  Copyright © 2020 Brandan McDevitt. All rights reserved.
//

import Foundation

// MARK: - Session
struct Session: Codable {
    let account: Account
    let session: CurrentSession
}

// MARK: - Account
struct Account: Codable {
    let registered: Bool
    let key: String
}

// MARK: - SessionClass
struct CurrentSession: Codable {
    let id, expiration: String
}

