//
//  BaseDecoder.swift
//  army of ones
//
//  Created by Sergio Bernal Reyes on 11/19/19.
//  Copyright © 2019 Sergio Bernal Reyes. All rights reserved.
//
import Foundation

protocol BaseDecoder {
    func decode<T: Codable>(data: Data) -> T?
}
