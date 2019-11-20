//
//  ViewController.swift
//  army of ones
//
//  Created by Sergio Bernal Reyes on 11/19/19.
//  Copyright © 2019 Sergio Bernal Reyes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CurrencyService().getGBGCurrency { (response: Result<CurrencyResponse, ErrorResponse>) in
            switch response {                
            case .success(let data):
                print("got currencies: \(data.rates.count)")
            case .failure(let error):
                print("")
            }
        }
    }
}

