//
//  UIButtonExtension.swift
//  iOS-Calculator
//
//  Created by Valerio Colantonio on 22/7/21.
//

import UIKit

    private var originalBackgroundColor: UIColor?;
    private var originalTextColor: UIColor?;

extension UIButton {

    func roundCornerBorders() {
        layer.cornerRadius = bounds.height/2
        clipsToBounds = true
    }

    // Shine effects
    func shineEffect() {
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0.5
        }) { (completation) in
            UIView.animate(withDuration: 0.1, animations: {
                self.alpha = 1
            })
        }
    }
    
    func  invertColors() {
        if originalBackgroundColor == nil{
            originalBackgroundColor = backgroundColor!
        }

        if originalTextColor == nil{
            originalTextColor = titleColor(for: .normal)
        }

        backgroundColor = originalTextColor
        setTitleColor(originalBackgroundColor, for: .normal)
    }
    
    func resetColors() {
        if originalBackgroundColor != nil{
            backgroundColor = originalBackgroundColor
        }
        
        if originalTextColor != nil{
            setTitleColor(originalTextColor, for: .normal)
        }
    }
}
