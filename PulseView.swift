//
//  PulseView.swift
//  PulseView
//
//  Created by Pavel Lukandiy on 16.02.17.
//  Copyright © 2017 Павел. All rights reserved.
//

import UIKit

class PulseView: UIView {
    
    private let START_VIEW_DIMENSION: CGFloat = 1
    private let ANIMATION_ID = "pulse_scale_animation"
    
    open var colors: [UIColor] = []
    open var animationTime: TimeInterval = 0.3
    open var animationPause: TimeInterval = 1
    
    public private(set) var animating = false
    
    private let contentView = UIView()
    private weak var tempView: UIView?
    private var currentColor = 0
    
    private var maxDimension: CGFloat {
        return frame.width > frame.height ? frame.width : frame.height
    }
    
    private var transformMultiplier: CGFloat {
        return START_VIEW_DIMENSION / maxDimension
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    convenience init(colors: [UIColor]) {
        self.init(frame: .zero)
        self.colors = colors
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = bounds
    }
    
    private func commonInit() {
        backgroundColor = .clear
        addSubview(contentView)
    }
    
    public func startAnimating() {
        
        currentColor = 0
        
        if !animating {
            animate()
            animating = true
        }
    }
    
    public func stopAnimating() {
        animating = false
        layer.removeAnimation(forKey: ANIMATION_ID)
        tempView?.removeFromSuperview()
    }
    
    override func animationDidStop(_ animation: CAAnimation, finished flag: Bool) {
        
        if animation.description == ANIMATION_ID {
            
            currentColor += 1
            if currentColor > colors.count - 1 {
                currentColor = 0
            }
            
            if animating {
                DispatchQueue.main.asyncAfter(deadline: .now() + animationPause, execute: {
                    self.tempView?.removeFromSuperview()
                    self.animate()
                })
            } else {
                tempView?.removeFromSuperview()
            }
        }
    }
    
    private func animate() {
        
        if colors.count == 0 {
            return
        }
        
        if tempView != nil {
            tempView!.removeFromSuperview()
        }
        
        let view = makeView()
        view.transform = CGAffineTransform(scaleX: transformMultiplier, y: transformMultiplier)
        view.backgroundColor = colors[currentColor]
        
        contentView.addSubview(view)
        tempView = view
        
        UIView.beginAnimations(ANIMATION_ID, context: nil)
        UIView.setAnimationDuration(animationTime)
        UIView.setAnimationDelegate(self)
        view.transform = .identity
        UIView.commitAnimations()
    }
    
    private func makeView() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: maxDimension, height: maxDimension))
        view.center = center
        view.layer.masksToBounds = true
        view.layer.cornerRadius = maxDimension / 2
        
        return view
    }
    
}
