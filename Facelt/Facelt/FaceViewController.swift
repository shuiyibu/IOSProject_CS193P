//
//  ViewController.swift
//  Facelt
//
//  Created by LangDylan on 2017/5/3.
//  Copyright © 2017年 Dylan Lang. All rights reserved.
//

import UIKit

class FaceViewController: VCLLoggingViewController {
    
    
    @IBOutlet weak var faceview: FaceView!{
        didSet{
            let handler = #selector(FaceView.changeScale(byReactingTo:))
            let pinchRecognizer = UIPinchGestureRecognizer(target: faceview, action: handler)
            faceview.addGestureRecognizer(pinchRecognizer)
            
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleEyes(byReactingTo:)))
            tapRecognizer.numberOfTapsRequired = 1
            faceview.addGestureRecognizer(tapRecognizer)
            
            let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(increaseHappiness))
            swipeUpRecognizer.direction = .up
            faceview.addGestureRecognizer(swipeUpRecognizer)
            let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(decreaseHappiness))
            swipeDownRecognizer.direction = .down
            faceview.addGestureRecognizer(swipeDownRecognizer)
            
            updateUI()
        }
    }
    
    func increaseHappiness() {
        expression = expression.happier
    }
    
    func decreaseHappiness() {
        expression = expression.sadder
    }
    
    func toggleEyes(byReactingTo tapRecognizer: UITapGestureRecognizer) {
        if tapRecognizer.state == .ended{
            let eyes: FacialExpression.Eyes = (expression.eyes == .closed) ? .open : .closed
            expression = FacialExpression(eyes: eyes, mouth: expression.mouth)
        }
    }
    
    var expression = FacialExpression(eyes: .closed, mouth: .frown){
        didSet{
            updateUI()
        }
    }
    
    private func updateUI()
    {
        switch expression.eyes {
        case .open:
            faceview?.eyesOpen = true
        case .closed:
            faceview?.eyesOpen = false
        case .squinting:
            faceview?.eyesOpen = false
        }
        faceview?.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
    }
    
    private let mouthCurvatures = [FacialExpression.Mouth.grin:0.5, .frown:-1.0, .smile:1.0, .neutral:0.0, .smirk:-0.5]
}

