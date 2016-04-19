//
//  ViewController.swift
//  customCoreAnimationTest
//
//  Created by Jay Maloney on 4/19/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import UIKit

class ViewController: UIViewController, HolderViewDelegate {
    
    var holderView = HolderView(frame: CGRectZero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        addHolderView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addHolderView() {
        let boxSize: CGFloat = 100.0
        holderView.frame = CGRect(x: view.bounds.width / 2 - boxSize / 2,
                                  y: view.bounds.height / 2 - boxSize / 2,
                                  width: boxSize,
                                  height: boxSize)
        holderView.parentFrame = view.frame
        holderView.delegate = self
        view.addSubview(holderView)
        holderView.addOval()
    }
    
    func animateLabel() {
        // 1
        holderView.removeFromSuperview()
        view.backgroundColor = Colors.altBlue
        
        // 2
        let image: UIImageView = UIImageView(frame: view.frame)
        image.image = UIImage(named: "krushWhite")
        image.contentMode = UIViewContentMode.ScaleAspectFit
        image.transform = CGAffineTransformScale(image.transform, 0.25, 0.25)
        view.addSubview(image)
        
        // 3
        UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.CurveEaseInOut,
                                   animations: ({
                                    image.transform = CGAffineTransformScale(image.transform, 4.0, 4.0)
                                   }), completion: { finished in
                                    self.addButton()
        })
    }
    
    func addButton() {
        let button = UIButton()
        button.frame = CGRectMake(0.0, 0.0, view.bounds.width, view.bounds.height)
        button.addTarget(self, action: #selector(ViewController.buttonPressed(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(button)
    }
    
    func buttonPressed(sender: UIButton!) {
        view.backgroundColor = Colors.white
//        view.subviews.map({ $0.removeFromSuperview() })
        holderView = HolderView(frame: CGRectZero)
        addHolderView()
    }
}


