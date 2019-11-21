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
    @IBOutlet weak var imageHeightconstraint: NSLayoutConstraint!
    
    var maxHeight: CGFloat = 0
    
    @IBInspectable var image: UIImage? {
        didSet {
            flagImageView.image = image
        }
    }
    
    @IBInspectable var barPercent: CGFloat = 0.0 {
        didSet {
            guard barPercent >= 0 && barPercent <= 100 else { return }
            updateHeight(animationTime: 2)
        }
    }
    
    func updateHeight(animationTime: TimeInterval) {
        if barPercent < 50 {
            flagImageView.contentMode = .redraw
        }
        
        let percent = self.barPercent / 100
        self.imageHeightconstraint.constant = self.maxHeight * percent
        
        UIView.animate(withDuration: animationTime) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func layoutSubviews() {
        maxHeight = self.bounds.size.height
    }
    
    func adjustView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.updateHeight(animationTime: 0.1)
        }
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
