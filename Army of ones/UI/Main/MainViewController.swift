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
    
    
    let model = MainViewModel()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBindings()
        model.getCurrencies()
    }
}

// MARK: UI Set up
extension MainViewController {
    
    
    func addBindings(){
        inputTextField.rx.value.orEmpty.debounce(.milliseconds(500), scheduler: MainScheduler.instance )
            .bind(to: model.inputText).disposed(by: bag)
        
        model.subjectOnLoading.subscribe(onNext: { (isLoading) in
            if isLoading {
                ProgressHUD.show()
            } else{
                ProgressHUD.dismiss()
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
    }
}
