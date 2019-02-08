//
//  HelperExtensions.swift
//  Project-6
//
//  Created by Mike Conner on 2/7/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
