//
//  Logger.swift
//  army of ones
//
//  Created by Sergio Bernal Reyes on 11/19/19.
//  Copyright © 2019 Sergio Bernal Reyes. All rights reserved.
//

import Foundation

enum LogCase {
    case Network
    case Debug
    case Other
}

class Logger {
    static let shared = Logger()
    
    func log<T: Any>(from className: T, with logCase: LogCase, message: String) {
        switch logCase {
        case .Network:
            print("📡 request \(Swift.type(of: className)) - \(message)")
        case .Debug:
            print("💻 \(Swift.type(of: className)):: \(message)")
        case .Other:
            print("📻 \(Swift.type(of: className)) - \(message)")
        }
    }
    
    private init(){}
}
