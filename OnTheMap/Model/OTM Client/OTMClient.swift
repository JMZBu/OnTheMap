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
                DispatchQueue.main.async {
                    completion([], error)
                    print("There was an error fetching the data: \(String(describing: error))")
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let userLocationResponse = try decoder.decode(UserList.self, from: data)
                DispatchQueue.main.async {
                    completion(userLocationResponse.results, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    print("There was an error parsing the data: \(error)")
                    completion([], error)
                }
            }

        }
        task.resume()
    }
    
}
