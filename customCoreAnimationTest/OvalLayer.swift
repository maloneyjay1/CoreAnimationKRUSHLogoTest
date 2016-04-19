//
//  OvalLayer.swift
//  customCoreAnimationTest
//
//  Created by Jay Maloney on 4/19/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import UIKit

class OvalLayer: CAShapeLayer {
    
    let animationDuration: CFTimeInterval = 0.3
    
    override init() {
        super.init()
        fillColor = Colors.altRed.CGColor
        path = ovalPathSmall.CGPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var ovalPathSmall: UIBezierPath {
        return UIBezierPath(ovalInRect: CGRect(x: 50.0, y: 50.0, width: 0.0, height: 0.0))
    }
    
    var ovalPathLarge: UIBezierPath {
        return UIBezierPath(ovalInRect: CGRect(x: 2.5, y: 17.5, width: 95.0, height: 95.0))
    }
    
    var ovalPathSquishVertical: UIBezierPath {
        return UIBezierPath(ovalInRect: CGRect(x: 2.5, y: 20.0, width: 95.0, height: 90.0))
    }
    
    var ovalPathSquishHorizontal: UIBezierPath {
        return UIBezierPath(ovalInRect: CGRect(x: 5.0, y: 20.0, width: 90.0, height: 90.0))
    }
    
    func expand() {
        let expandAnimation: CABasicAnimation = CABasicAnimation(keyPath: "path")
        expandAnimation.fromValue = ovalPathSmall.CGPath
        expandAnimation.toValue = ovalPathLarge.CGPath
        expandAnimation.duration = animationDuration
        expandAnimation.fillMode = kCAFillModeForwards
        expandAnimation.removedOnCompletion = false
        addAnimation(expandAnimation, forKey: nil)
    }
    
    func wobble() {
        let wobble1: CABasicAnimation = CABasicAnimation(keyPath: "path")
        wobble1.fromValue = ovalPathLarge.CGPath
        wobble1.toValue = ovalPathSquishVertical.CGPath
        wobble1.beginTime = 0.0
        wobble1.duration = animationDuration
        
        let wobble2: CABasicAnimation = CABasicAnimation(keyPath: "path")
        wobble2.fromValue = ovalPathSquishVertical.CGPath
        wobble2.toValue = ovalPathLarge.CGPath
        wobble2.beginTime = wobble1.beginTime + wobble1.duration
        wobble2.duration = animationDuration
        
        let wobble3: CABasicAnimation = CABasicAnimation(keyPath: "path")
        wobble3.fromValue = ovalPathLarge.CGPath
        wobble3.toValue = ovalPathSquishHorizontal.CGPath
        wobble3.beginTime = wobble2.beginTime + wobble2.duration
        wobble3.duration = animationDuration
        
        let wobble4: CABasicAnimation = CABasicAnimation(keyPath: "path")
        wobble4.fromValue = ovalPathSquishHorizontal.CGPath
        wobble4.toValue = ovalPathLarge.CGPath
        wobble4.beginTime = wobble3.beginTime + wobble3.duration
        wobble4.duration = animationDuration
        
        let animationGroup: CAAnimationGroup = CAAnimationGroup()
        animationGroup.animations = [wobble1, wobble2, wobble3, wobble4]
        animationGroup.duration = wobble4.beginTime + wobble4.duration
        animationGroup.repeatCount = 2
        addAnimation(animationGroup, forKey: nil)
        
    }
    
    func contract() {
        let contractAnimation: CABasicAnimation = CABasicAnimation(keyPath: "path")
        contractAnimation.fromValue = ovalPathLarge.CGPath
        contractAnimation.toValue = ovalPathSmall.CGPath
        contractAnimation.duration = animationDuration
        contractAnimation.fillMode = kCAFillModeForwards
        contractAnimation.removedOnCompletion = false
        addAnimation(contractAnimation, forKey: nil)
    }
    
}
