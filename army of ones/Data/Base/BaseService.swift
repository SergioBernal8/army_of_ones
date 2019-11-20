//
//  BaseService.swift
//  army of ones
//
//  Created by Sergio Bernal Reyes on 11/19/19.
//  Copyright © 2019 Sergio Bernal Reyes. All rights reserved.
//
import Foundation

typealias ServerResponse<T: Codable> = (Result<T, ErrorResponse>) -> ()

protocol BaseService {
    func printError(with error: ErrorResponse)
    func printResponse<T>(response: T, logCase: LogCase)
}

struct ErrorResponse: Error {
    var errorType: ErrorType
    var errorMessage: String
}


enum ErrorType {
    case serverError
    case badRequest
    case unableToParseResponse
    case other
}
