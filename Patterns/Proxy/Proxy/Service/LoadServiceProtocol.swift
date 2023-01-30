//
//  LoadServiceProtocol.swift
//  Proxy
//
//  Created by Илья Казначеев on 28.01.2023.
//

import Foundation

protocol LoadServiceProtocol {
    
    func loadImage(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
    
}
