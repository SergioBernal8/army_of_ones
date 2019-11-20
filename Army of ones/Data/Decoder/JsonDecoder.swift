//
//  JsonDecoder.swift
//  army of ones
//
//  Created by Sergio Bernal Reyes on 11/19/19.
//  Copyright © 2019 Sergio Bernal Reyes. All rights reserved.
//
import Foundation

class JsonDecoder: BaseDecoder {
    func decode<T>(data: Data) -> T? where T : Codable {
        do {
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        } catch {
            return nil
        }
    }
}
