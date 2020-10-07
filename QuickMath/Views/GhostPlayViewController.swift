//
//  GhostPlayViewController.swift
//  QuickMath
//
//  Created by Mark ⠀ on 8/23/20.
//  Copyright © 2020 Mark ⠀. All rights reserved.
//

//TODO: Implement GhostPlay.. heh
// Implementation scrapped. *For now

import UIKit

class GhostPlayViewController: UIViewController, UIAdaptivePresentationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "popOver" {
                let popoverViewController = segue.destination
                popoverViewController.modalPresentationStyle = .popover
                popoverViewController.presentationController?.delegate = self
                
         }
    }
        
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }

}
