//
//  NIBView.swift
//  IosBlueprint
//
//  Created by ibrahim on 11/11/16.
//  Copyright © 2016 Indosytem. All rights reserved.
//

import Foundation
import UIKit

protocol NIBViewProtocol:NSObjectProtocol {
    func xibSetup()
    func loadViewFromNib() -> UIView!
}
