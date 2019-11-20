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
        Logger.shared.log(from: self, with: .Error, message: "\(error.errorType)::\(error.errorMessage)")
    }
    
    func printResponse<T>(response: T, logCase: LogCase = .Network) {
        Logger.shared.log(from: self, with: logCase, message: "Data: \(response)")
    }
    
    static let shared = NetworkService()
    
    @discardableResult
    func performRequest<T: Codable> (url: URLConvertible, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, handler: @escaping ServerResponse<T>) -> DataRequest {
        Logger.shared.log(from: self, with: .Network, message: "Request to url: \(url)")
        let request = Alamofire.request(url, method: method, parameters: parameters, headers: headers).validate().response{ urlResponse in
            let code = urlResponse.response?.statusCode ?? 404
            if let error = urlResponse.error {
                if code == 404 {
                    let error = ErrorResponse(errorType: .badRequest, errorMessage: error.localizedDescription)
                    self.printError(with: error)
                    handler(.failure(error))
                } else {
                    let err = ErrorResponse(errorType: .serverError, errorMessage: "Code: \(code) \(error.localizedDescription)")
                    self.printError(with: err)
                    handler(.failure(err))
                }
            } else {
                if code == 200 {
                    if let responseData = urlResponse.data {
                        let data: T? = JsonDecoder().decode(data: responseData)
                        if let parsedObject = data {
                            self.printResponse(response: parsedObject, logCase: .Other)
                            handler(.success(parsedObject))
                        } else {
                            let text = String(data: responseData, encoding: .utf8)
                            let error = ErrorResponse(errorType: .unableToParseResponse, errorMessage: "Cannot parse object \(String(describing: text))")
                            self.printError(with: error)
                            handler(.failure(error))
                        }
                    } else {
                        let error = ErrorResponse(errorType: .unableToParseResponse, errorMessage: "Empty Data")
                        self.printError(with: error)
                        handler(.failure(error))
                    }
                } else {
                    let error = ErrorResponse(errorType: .serverError, errorMessage: "Code: \(code) \(urlResponse.response.debugDescription)")
                    self.printError(with: error)
                    handler(.failure(error))
                }
                
            }
        }
        return request
    }
    
    private init() {}
}
