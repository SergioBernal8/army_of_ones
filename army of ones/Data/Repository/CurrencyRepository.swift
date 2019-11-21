//
//  CurrencyRepository.swift
//  army of ones
//
//  Created by Sergio Bernal Reyes on 11/19/19.
//  Copyright © 2019 Sergio Bernal Reyes. All rights reserved.
//

protocol CurrencyRepository {
    func getGBGCurrency(completion: @escaping ServerResponse<CurrencyResponse>)
}
