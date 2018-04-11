//
//  Shake.swift
//  ToggleDNS
//
//  Created by Joseph Goodrick on 4/10/18.
//  Copyright © 2018 G.O.O.D. Corp. All rights reserved.
//

import Cocoa

extension NSView {
    func shake(count : CGFloat = 4,for duration : TimeInterval = 0.5,withTranslation translation : CGFloat = 5) {
        
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.repeatCount = Float(count)
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        let centerY = self.frame.origin.y + (self.frame.size.height / 2)
        animation.fromValue = CGPoint(x: -translation, y: centerY)
        animation.toValue = CGPoint(x: translation, y: centerY)
        layer?.add(animation, forKey: "shake")
    }
}
