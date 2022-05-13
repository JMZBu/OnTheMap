//
//  UserData.swift
//  OnTheMap
//
//  Created by James Butler on 5/13/22.
//

import Foundation

class UserData: Codable {
    let createdAt: String
    let firstName: String
    let lastName: String
    let longitude: Float
    let latitude: Float
    let mapString: String
    let mediaURL: String
    let objectId: String
    let uniqueKey: String
    let updatedAt: String
}
