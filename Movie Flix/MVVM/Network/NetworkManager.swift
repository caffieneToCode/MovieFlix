//
//  ServiceManager.swift
//  Movie Flix
//
//  Created by Ashish Verma on 5/17/20.
//  Copyright © 2020 Ashish Verma. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let sharedInstance: NetworkManager = {
        let instance = NetworkManager()
        return instance
    }()
    
    private init(){}

    func makeRequestWithURL(urlString: String, type: RequestType, parameters: [String: AnyObject]?, success: @escaping (_ data: Data?) -> ()) {
        do {
            let request = try createRequestWithURl(urlString: urlString, type: type, parameters: parameters)
            URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
                if error == nil && data != nil {
                    success(data!)
                } else {
                    print(error.debugDescription)
                }
                }.resume()
        } catch {
            print("\nUnable to form request with url:\n\(urlString)\nError Description\(error.localizedDescription)")
        }
    }
    
    private func createRequestWithURl(urlString: String, type: RequestType, parameters: [String: AnyObject]?) throws -> (URLRequest) {
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = type.rawValue
        
        return request
    }
    
    enum RequestType: String {
        case get = "GET"
        case post = "POST"
    }
}
