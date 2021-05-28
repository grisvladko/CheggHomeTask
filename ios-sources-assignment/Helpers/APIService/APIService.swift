//
//  APIService.swift
//  ios-sources-assignment
//
//  Created by hyperactive on 28/05/2021.
//  Copyright © 2021 Chegg. All rights reserved.
//

import Foundation

class APIService: NSObject {
    
    public func fetch(_ urlString: String,
                        _ completion : @escaping (Data?, Error?) -> Void) {
        
        let queue = DispatchQueue(label: "com.task", qos: .background, attributes: .concurrent)
        
        guard let url = URL(string: urlString) else {
            return completion(nil, NSError(domain: "Bad Access URL", code: -1, userInfo: nil))
        }
        
        queue.async {
            let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
                if let error = error { completion(nil, error) }
                if let data = data { completion(data, nil) }
            }
            task.resume()
        }
    }
}
