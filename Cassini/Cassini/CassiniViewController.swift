//
//  CassiniViewController.swift
//  Cassini
//
//  Created by LangDylan on 2017/6/2.
//  Copyright © 2017年 Dylan Lang. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController,UISplitViewControllerDelegate
{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.splitViewController?.delegate = self
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let url = DemoURL.NASA[segue.identifier ?? ""]{
            if let imageVC = (segue.destination.contents as? ImageViewController){
                imageVC.imageURL = url
                imageVC.title = (sender as? UIButton)?.currentTitle
            }
        }
    }
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if primaryViewController.contents == self {
            if let ivc = secondaryViewController.contents as? ImageViewController, ivc.imageURL == nil{
                return true
            }
        }
        return false
    }
    
    
}

extension UIViewController
{
    var contents: UIViewController{
        if let navcon = self as? UINavigationController{
            return navcon.visibleViewController ?? self
        }else{
            return self
        }
    }
}

