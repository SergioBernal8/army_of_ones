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


enum CurrencyChart {
    case gbp
    case eur
    case jpy
    case brl
}

typealias ChartViewData = (chart: CurrencyChart, percent: Double, army: Double)

class MainViewModel {
    
    let inputText = BehaviorRelay<String>(value:"")
    
    let subjectOnError = PublishSubject<ErrorResponse>()
    let subjectOnMessage = PublishSubject<String>()
    let subjectOnLoading = PublishSubject<Bool>()
    let subjectChart = PublishSubject<ChartViewData>()
    
    var rates = [String:Double]()
    let bag = DisposeBag()
    var chartScale = 1.0
    var currencyRepository: CurrencyRepository
    
    init(repository: CurrencyRepository) {
        self.currencyRepository = repository
        
        inputText.asObservable().distinctUntilChanged().subscribe(onNext: { (text) in
            if let amount = Double(text), amount > 0 {
                self.convertCurrency(for: amount)
            }
        }).disposed(by: bag)
    }
    
    func updateScale(with percent: Double){
        if percent > 100.0 {
            let scale = 100 / percent
            if scale < chartScale {
                chartScale = scale
            }
        }
    }
    
    func convertCurrency(for amount: Double) {
        if rates.isEmpty {
            self.subjectOnError.onNext(ErrorResponse(errorType: .other, errorMessage: "Currencies rates not available. Please reload"))            
        } else {
            chartScale = 1.0
            if let gbpRate = rates["GBP"] {
                let percent = gbpRate * 100
                updateScale(with: percent)
            }
            if let eurRate = rates["EUR"] {
                let percent = eurRate * 100
                updateScale(with: percent)
            }
            if let jpyRate = rates["JPY"] {
                let percent = jpyRate * 100
                updateScale(with: percent)
            }
            if let brlRate = rates["BRL"] {
                let percent = brlRate * 100
                updateScale(with: percent)
            }
            calculatePercentages(amount: amount)
        }
    }
    
    private func calculatePercentages(amount: Double) {
        if let gbpRate = rates["GBP"] {
            let gbpArmy = CurrencyConverter.instance.convert(amount: amount, rate: gbpRate)
            let percent = (gbpRate * 100) * chartScale
            subjectChart.onNext(ChartViewData(.gbp, percent, gbpArmy))
        }
        if let eurRate = rates["EUR"] {
            let eurArmy = CurrencyConverter.instance.convert(amount: amount, rate: eurRate)
            let percent = (eurRate * 100) * chartScale
            subjectChart.onNext(ChartViewData(.eur, percent, eurArmy))
        }
        if let jpyRate = rates["JPY"] {
            let jpyArmy = CurrencyConverter.instance.convert(amount: amount, rate: jpyRate)
            let percent = (jpyRate * 100) * chartScale
            subjectChart.onNext(ChartViewData(.jpy, percent, jpyArmy))
        }
        if let brlRate = rates["BRL"] {
            let brlArmy = CurrencyConverter.instance.convert(amount: amount, rate: brlRate)
            let percent = (brlRate * 100) * chartScale
            subjectChart.onNext(ChartViewData(.brl, percent, brlArmy))
        }
    }
    
    func getCurrencies(){
        subjectOnLoading.onNext(true)
        
        currencyRepository.getGBGCurrency { (response: Result<CurrencyResponse, ErrorResponse>) in
            self.subjectOnLoading.onNext(false)
            switch response {
            case .success(let data):
                self.rates = data.rates
            case .failure(let error):
                self.subjectOnError.onNext(error)
            }
        }
    }
}
