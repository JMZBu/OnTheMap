//
//  OTMClient.swift
//  OnTheMap
//
//  Created by James Butler on 5/13/22.
//

import Foundation

class OTMClient {

    class func getUserDetails(completion: @escaping ([UserData], Error?) -> Void) {
        let request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/StudentLocation")!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion([], error)
                return
            }
            let decoder = JSONDecoder()
            let userLocationResponse = try! decoder.decode(UserList.self, from: data)
            completion(userLocationResponse.results, nil)

        }
        task.resume()
    }
    
}
