//
//  LoadImageService.swift
//  Proxy
//
//  Created by Илья Казначеев on 28.01.2023.
//

import Foundation

class LoadImageService: LoadServiceProtocol {
    
    func loadImage(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        
        let session = URLSession(configuration: config)
        session.dataTask(with: url, completionHandler: completion).resume()
    }
    
}
