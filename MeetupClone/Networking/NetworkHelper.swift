//
//  NetworkHelper.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/22/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

class NetworkHelper {
    private init() {}
    
    static let shared = NetworkHelper()
    
    typealias Handler = (Result<Data, AppError>) -> Void
    
    func performDataTask(URLEndpoint: String, httpMethod: String, httpBody: Data?, httpHeader:  (value: String, headerProperty: String)?, completionHandler: @escaping Handler) {
        guard let url = URL(string: URLEndpoint) else {
            completionHandler(.failure(.badURL("Could not create URL from String")))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.httpBody = httpBody
        if let httpHeader = httpHeader {
            request.setValue(httpHeader.value, forHTTPHeaderField: httpHeader.headerProperty)
        }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completionHandler(.failure(.networkError(error)))
            }
            if let data = data {
                completionHandler(.success(data))
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
                else {
                    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -999
                    completionHandler(.failure(.badStatusCode(statusCode.description)))
                    return
            }
        }
        task.resume()
    }
}
