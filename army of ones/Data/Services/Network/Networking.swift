//
//  Networking.swift
//  army of ones
//
//  Created by Sergio Bernal Reyes on 11/19/19.
//  Copyright © 2019 Sergio Bernal Reyes. All rights reserved.
//

import Foundation
import Alamofire

protocol Networking {
    func performRequest<T: Codable>(url: URLConvertible, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, handler: @escaping ServerResponse<T>) -> DataRequest
}

class NetworkService: Networking, BaseService {
    
    func printError(with error: ErrorResponse) {
        Logger.shared.log(from: self, with: .Network, message: "\(error.errorType)::\(error.localizedDescription)")
    }
    
    func printResponse<T>(response: T) {
        Logger.shared.log(from: self, with: .Network, message: "Data: \(response)")
    }
    
    static let shared = NetworkService()
    
    @discardableResult
    func performRequest<T: Codable> (url: URLConvertible, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, handler: @escaping ServerResponse<T>) -> DataRequest {
        let request = Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseData {
            (response: DataResponse<Data>) in
            if let error = response.error {
                let code = response.response?.statusCode
                if code == 404 {
                    let error = ErrorResponse(errorType: .badRequest, errorMessage: error.localizedDescription)
                    self.printError(with: error)
                    handler(.failure(error))
                } else {
                    let error = ErrorResponse(errorType: .serverError, errorMessage: error.localizedDescription)
                    self.printError(with: error)
                    handler(.failure(error))
                }
            } else {
                if let responseData = response.data {
                    let data: T? = JsonDecoder().decode(data: responseData)
                    if let parsedObject = data {
                        self.printResponse(response: parsedObject)
                        handler(.success(parsedObject))
                    } else {
                        let error = ErrorResponse(errorType: .unableToParseResponse, errorMessage: "Cannot parse object")
                        self.printError(with: error)
                        handler(.failure(error))
                    }
                } else {
                    let error = ErrorResponse(errorType: .unableToParseResponse, errorMessage: "Cannot parse object")
                    self.printError(with: error)
                    handler(.failure(error))
                }
                
            }
        }
        return request
    }
    
    private init() {}
}

