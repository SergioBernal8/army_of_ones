//
//  MainViewModel.swift
//  army of ones
//
//  Created by Sergio Bernal Reyes on 11/20/19.
//  Copyright © 2019 Sergio Bernal Reyes. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class MainViewModel {
    
    let inputText = BehaviorRelay<String>(value:"")
    
    let subjectOnError = PublishSubject<ErrorResponse>()
    let subjectOnLoading = PublishSubject<Bool>()
    
    init() {
        inputText.asObservable().subscribe(onNext: { (text) in
            print("\(text)")
        })
    }
    
    func getCurrencies(){
        subjectOnLoading.onNext(true)
        
        CurrencyService().getGBGCurrency { (response: Result<CurrencyResponse, ErrorResponse>) in
            self.subjectOnLoading.onNext(false)
            switch response {
            case .success(let data):
                print("got currencies: \(data.rates.count)")
            case .failure(let error):
                print("")
                self.subjectOnError.onNext(error)
            }
        }
    }
}
