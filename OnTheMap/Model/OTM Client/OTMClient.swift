//
//  OTMClient.swift
//  OnTheMap
//
//  Created by James Butler on 5/13/22.
//

import Foundation

class OTMClient {

    enum Endpoints {
        
        case getUserDetails
        
        var stringValue: String {
            switch self {
            case .getUserDetails: return "https://onthemap-api.udacity.com/v1/StudentLocation"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }

//MARK: GET Requests
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, response: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                    print("There was an error fetching the data: \(String(describing: error))")
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                    print("There was an error parsing the data: \(error)")
                }
            }
        }
        task.resume()
    }
    
    class func getUserDetails(completion: @escaping ([UserData], Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getUserDetails.url, response: UserList.self) { response, error in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion([], error)
            }
        }

//        let request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/StudentLocation")!)
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data else {
//                DispatchQueue.main.async {
//                    completion([], error)
//                    print("There was an error fetching the data: \(String(describing: error))")
//                }
//                return
//            }
//            let decoder = JSONDecoder()
//            do {
//                let userLocationResponse = try decoder.decode(UserList.self, from: data)
//                DispatchQueue.main.async {
//                    completion(userLocationResponse.results, nil)
//                }
//            } catch {
//                DispatchQueue.main.async {
//                    print("There was an error parsing the data: \(error)")
//                    completion([], error)
//                }
//            }
//
//        }
//        task.resume()
    }
    
//MARK: POST Requests
    
    class func taskForPOSTrequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, response: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = body
        request.httpBody = try! JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }

        }
        task.resume()
    }
}
