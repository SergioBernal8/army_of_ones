//
//  MockEncoder.swift
//  army of ones
//
//  Created by Sergio Bernal Reyes on 11/19/19.
//  Copyright © 2019 Sergio Bernal Reyes. All rights reserved.
//

import Foundation

class MockEncoder: BaseEncoder {
    
    var mockCase: MockEncoderCase = MockEncoderCase.success
    
    func encode<T>(data: T) -> String where T: Encodable {
        if mockCase == .success {
            let jsonData = try! JSONEncoder().encode(data)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            return jsonString
        } else {
            return ""
        }
    }
}

enum MockEncoderCase {
    case success
    case error
}
