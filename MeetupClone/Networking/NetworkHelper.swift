//
//  NetworkHelper.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/22/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// Used to handle network requests.
class NetworkHelper {
    
    typealias Handler = (Result<Data, AppError>) -> Void
    
    /// Uses URLSession to make network request.
    /// - Parameter URLEndpoint: Used to form a URL Request.
    /// - Parameter httpMethod:  Represents the various HTTP Methods ex: GET, POST, DELETE.
    /// - Parameter httpBody: Data that will be used as the body of the request.
    /// - Parameter headerProperty: Value to be set for a Header
    /// - Parameter completionHandler: Handles the result of asynchronous call.
    func performDataTask(URLEndpoint: String, httpMethod: HTTPMethods, httpBody: Data?, httpHeader: (value: String, headerProperty: String)?, completionHandler: @escaping Handler) {
        
        guard let url = URL(string: URLEndpoint) else {
            completionHandler(.failure(.badURL("Could not create URL from String")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = httpBody
        
        if let httpHeader = httpHeader {
            request.setValue(httpHeader.value, forHTTPHeaderField: httpHeader.headerProperty)
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                
                if let error = error {
                    completionHandler(.failure(.networkError(error)))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode)
                    else {
                        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -999
                        completionHandler(.failure(.badStatusCode(statusCode.description)))
                        return
                }

                if let data = data {
                        completionHandler(.success(data))
                    return
                }
            }
        }
        task.resume()
    }
}
