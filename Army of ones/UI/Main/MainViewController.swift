//
//  MainViewController.swift
//  army of ones
//
//  Created by Sergio Bernal Reyes on 11/20/19.
//  Copyright © 2019 Sergio Bernal Reyes. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ProgressHUD

class MainViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet var inputTextField: UITextField!
    
    @IBOutlet weak var gbpCountLabel: UILabel!
    @IBOutlet weak var eurCountLabel: UILabel!    
    @IBOutlet weak var jpyCountLabel: UILabel!
    @IBOutlet weak var brlCountLabel: UILabel!
    @IBOutlet weak var gbpChartView: ChartView!
    @IBOutlet weak var eurChartView: ChartView!
    @IBOutlet weak var jpyChartView: ChartView!
    @IBOutlet weak var brlChartView: ChartView!
    
    let model = MainViewModel(repository: CurrencyService())
    let bag = DisposeBag()
    var hasInitalizated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBindings()
        setUpUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !hasInitalizated {
            hasInitalizated = true
            model.getCurrencies()
        }
    }
}

// MARK: UI Set up
extension MainViewController {
    
    func setUpUI(){
        self.gbpCountLabel.adjustsFontSizeToFitWidth = true
        self.eurCountLabel.adjustsFontSizeToFitWidth = true
        self.jpyCountLabel.adjustsFontSizeToFitWidth = true
        self.brlCountLabel.adjustsFontSizeToFitWidth = true
    }
    
    func addBindings() {
        inputTextField.rx.value.orEmpty.debounce(.milliseconds(500), scheduler: MainScheduler.instance )
            .bind(to: model.inputText).disposed(by: bag)
        
        model.subjectOnLoading.subscribe(onNext: { isLoading in
            if isLoading {
                ProgressHUD.show()
            } else {
                ProgressHUD.dismiss()
            }
        }).disposed(by: bag)
        
        model.subjectChart.subscribe(onNext: { chartData in
            switch chartData.chart {
            case .gbp:
                self.gbpChartView.barPercent = CGFloat(chartData.percent)
                self.gbpCountLabel.text = Formatter.instance.formatCurrency(amount: chartData.army)
            case .eur:
                self.eurChartView.barPercent = CGFloat(chartData.percent)
                self.eurCountLabel.text = Formatter.instance.formatCurrency(amount: chartData.army)
            case .jpy:
                self.jpyChartView.barPercent = CGFloat(chartData.percent)
                self.jpyCountLabel.text = Formatter.instance.formatCurrency(amount: chartData.army)
            case .brl:
                self.brlChartView.barPercent = CGFloat(chartData.percent)
                self.brlCountLabel.text = Formatter.instance.formatCurrency(amount: chartData.army)
            }
        }).disposed(by: bag)
        
        model.subjectOnMessage.subscribe(onNext: { message in
            self.showAlertWithMessage(with: message, handler: nil)
        }).disposed(by: bag)
        
        model.subjectOnError.subscribe(onNext: { errorResponse in
            self.showAlertWithMessage(with: errorResponse.errorMessage) { action in
                self.model.getCurrencies()
            }
        }).disposed(by: bag)
    }
    
    
    // Manage Transition from portrait to landscape
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let isIpad = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
        if UIDevice.current.orientation.isLandscape {
            stackView.spacing = isIpad ? 80 : 60
        } else {
            stackView.spacing = isIpad ? 30 : 20
        }
        
        gbpChartView.adjustView()
        eurChartView.adjustView()
        jpyChartView.adjustView()
        gbpChartView.adjustView()
    }
}


// MARK: Alerts
extension MainViewController {
    
    func showAlertWithMessage(with message: String, actionMessage: String = "Ok", handler: ((UIAlertAction)-> Void)?){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: actionMessage, style: UIAlertAction.Style.default, handler: handler))
        self.present(alert, animated: true, completion: nil)
    }
}
