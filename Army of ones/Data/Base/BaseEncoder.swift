//
//  BaseEncoder.swift
//  army of ones
//
//  Created by Sergio Bernal Reyes on 11/19/19.
//  Copyright © 2019 Sergio Bernal Reyes. All rights reserved.
//

protocol BaseEncoder {
    func encode<T: Encodable>(data: T) -> String
}
