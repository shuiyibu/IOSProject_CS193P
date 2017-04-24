//
//  HappinessViewController.swift
//  Happiness
//
//  Created by LangDylan on 23/01/2017.
//  Copyright © 2017 Dylan Lang. All rights reserved.
//

import UIKit


class HappinessViewController: UIViewController, FaceViewDataSource
{
    var happiness: Int = 100{ // 0 = very sad, 100 = ecstatic
               didSet{
            happiness=min(max(happiness, 0),100)
            print("happiness=\(happiness)")
            updateUI()
        }
    }
    
    private struct Constants{
        static let happinessGestureScale : CGFloat = 4
    }
   
    @IBAction func changeHappiness(_ gesture: UIPanGestureRecognizer) {
        
        switch gesture.state{
        case .ended: fallthrough
        case .changed:
            let translation = gesture.translation(in: faceView)
            let happinessChange = -Int(translation.y/Constants.happinessGestureScale)
            if happinessChange != 0{
            happiness += happinessChange
                gesture.setTranslation(CGPoint.zero, in: faceView)
            }
        default: break
        }
        
        
    }
    @IBOutlet weak var faceView: FaceView!{
        didSet{
            faceView.dataSource=self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
        }
    }
    
    
    private func updateUI(){
        faceView.setNeedsDisplay()
    }
    
    func  smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness-50)/50
    }
}
