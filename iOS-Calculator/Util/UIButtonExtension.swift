//
//  UIButtonExtension.swift
//  iOS-Calculator
//
//  Created by Valerio Colantonio on 22/7/21.
//

import UIKit

extension UIButton {
    
    // Rounding corner borders
    func round() {
        layer.cornerRadius = bounds.height/2
        clipsToBounds = true
    }

    // Shine effects
    func shine() {
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0.5
        }) { (completation) in
            UIView.animate(withDuration: 0.1, animations: {
                self.alpha = 1
            })
        }
    }
}
