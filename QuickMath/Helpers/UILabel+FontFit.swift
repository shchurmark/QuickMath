//
//  UILabel+FontFit.swift
//  QuickMath
//
//  Created by Mark ⠀ on 8/23/20.
//  Copyright © 2020 Mark ⠀. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func makeFontFitWidth() {
        self.numberOfLines = 1
        self.adjustsFontSizeToFitWidth = true
        self.baselineAdjustment = .alignCenters
        self.lineBreakMode = NSLineBreakMode.byClipping
    }
}
