//
//  MockDecoder.swift
//  army of ones
//
//  Created by Sergio Bernal Reyes on 11/19/19.
//  Copyright © 2019 Sergio Bernal Reyes. All rights reserved.
//

import Foundation

class MockDecoder: BaseDecoder {
    func decode<T>(data: Data) -> T? where T: Decodable {
        let jsonString = String(decoding: data, as: UTF8.self)
        let jsonData = jsonString.data(using: .utf8)!
        do {
            let object = try JSONDecoder().decode(T.self, from: jsonData)
            return object
        } catch {
            return nil
        }
    }
}
