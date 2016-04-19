//
//  HolderView.swift
//  customCoreAnimationTest
//
//  Created by Jay Maloney on 4/19/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import UIKit

protocol HolderViewDelegate:class {
    
    func animateLabel()
}

class HolderView: UIView {
    
    let ovalLayer = OvalLayer()
    let triangleLayer = TriangleLayer()
    let redRectangleLayer = RectangleLayer()
    let blueRectangleLayer = RectangleLayer()
    let arcLayer = ArcLayer()
    
    var parentFrame :CGRect = CGRectZero
    weak var delegate:HolderViewDelegate?
    
    func addOval() {
        layer.addSublayer(self.ovalLayer)
        self.ovalLayer.expand()
        
        NSTimer.scheduledTimerWithTimeInterval(0.28, target: self, selector: #selector(self.wobbleOval), userInfo: nil, repeats: false)
    }
    
    func wobbleOval() {
        layer.addSublayer(self.triangleLayer)
        ovalLayer.wobble()
        
        NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: #selector(self.drawAnimatedTriangle), userInfo: nil, repeats: false)
    }
    
    func drawAnimatedTriangle() {
        triangleLayer.animate()
        
        NSTimer.scheduledTimerWithTimeInterval(0.9, target: self, selector: #selector(self.spinAndTransform), userInfo: nil, repeats: false)
    }
    
    func spinAndTransform() {
        // 1
        layer.anchorPoint = CGPointMake(0.5, 0.7)
        
        // 2
        let rotationAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = CGFloat(M_PI * 2.0)
        rotationAnimation.duration = 0.45
        rotationAnimation.removedOnCompletion = true
        layer.addAnimation(rotationAnimation, forKey: nil)
        
        
        // 3
        ovalLayer.contract()
        
        // 4
        NSTimer.scheduledTimerWithTimeInterval(0.45, target: self,
                                               selector: #selector(self.drawRedAnimatedRectangle),
                                               userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(0.70, target: self,
                                               selector: #selector(self.drawBlueAnimatedRectangle),
                                               userInfo: nil, repeats: false)
    }
    
    func drawRedAnimatedRectangle() {
        layer.addSublayer(redRectangleLayer)
        redRectangleLayer.animateStrokeWithColor(Colors.altRed)
    }
    
    func drawBlueAnimatedRectangle() {
        layer.addSublayer(blueRectangleLayer)
        blueRectangleLayer.animateStrokeWithColor(Colors.altBlue)
        
        NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: #selector(self.drawArc), userInfo: nil, repeats: false)
    }
    
    func drawArc() {
        layer.addSublayer(arcLayer)
        arcLayer.animate()
        
        NSTimer.scheduledTimerWithTimeInterval(0.9, target: self, selector: #selector(self.expandView), userInfo: nil, repeats: false)
    }
    
    func expandView() {
        // 1
        backgroundColor = Colors.altBlue
        
        // 2
        frame = CGRectMake(frame.origin.x - blueRectangleLayer.lineWidth,
                           frame.origin.y - blueRectangleLayer.lineWidth,
                           frame.size.width + blueRectangleLayer.lineWidth * 2,
                           frame.size.height + blueRectangleLayer.lineWidth * 2)
        
        // 3
        layer.sublayers = nil
        
        // 4
        
        let frame2 = CGRectMake((frame.origin.x - blueRectangleLayer.lineWidth) + 65,
                                (frame.origin.y - blueRectangleLayer.lineWidth) + 85,
                                0,
                                0)
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut,
                                   animations: {
                                    self.frame = frame2
            }, completion: { finished in
                self.addLabel()
        })
        
    }
    
    func addLabel() {
        delegate?.animateLabel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
