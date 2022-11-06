//
//  Extensions.swift
//  TutorialView
//
//  Created by Олег Федоров on 05.11.2022.
//

import UIKit

extension UIView {
    func makeClearHole(rect: CGRect, anchorPoint: CGPoint) -> CAShapeLayer {
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.fillRule = .evenOdd
        maskLayer.fillColor = UIColor(white: 0, alpha: 0.6).cgColor
        
        let pathToOverlay = UIBezierPath(rect: self.bounds)
        pathToOverlay.append(UIBezierPath(roundedRect: rect,
                                          cornerRadius: rect.width / 2))
        pathToOverlay.usesEvenOddFillRule = true
        maskLayer.path = pathToOverlay.cgPath
        maskLayer.setAnchorPoint(anchorPoint)
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 3.0
        scaleAnimation.toValue = 1.0
        scaleAnimation.duration = 2
        maskLayer.add(scaleAnimation, forKey: nil)
        
        return maskLayer
    }
}

extension CALayer {
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * anchorPoint.x,
                               y: bounds.size.height * anchorPoint.y);

        newPoint = newPoint.applying(affineTransform())
        oldPoint = oldPoint.applying(affineTransform())

        var position = position

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        self.position = position
        anchorPoint = point
    }
}
