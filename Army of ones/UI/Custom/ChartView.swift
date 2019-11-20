//
//  ChartView.swift
//  army of ones
//
//  Created by Sergio Bernal Reyes on 11/20/19.
//  Copyright © 2019 Sergio Bernal Reyes. All rights reserved.
//

import UIKit

@IBDesignable class ChartView: UIView {
    var view: UIView!
    
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var topHeightConstraint: NSLayoutConstraint!
    
    var maxHeight: CGFloat = 0
    
    @IBInspectable var image: UIImage? {
        didSet {
            flagImageView.image = image
        }
    }
    
    @IBInspectable var barPercent: CGFloat = 0.0 {
           didSet {
               guard barPercent >= 0 && barPercent <= 100 else { return }
            topHeightConstraint.constant = maxHeight - (maxHeight * barPercent / 100)
           }
       }

    
    override func layoutSubviews() {
        maxHeight = self.view.bounds.height
         topHeightConstraint.constant = maxHeight - (maxHeight * barPercent / 100)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpNib()
    }
    
    func setUpNib() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        self.view = view
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ChartView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
