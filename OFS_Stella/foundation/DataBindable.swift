//
//  ViewModelBindable.swift
//  OFS_Stella
//
//  Created by William Izzo on 16/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation
import UIKit

/**
 * Declares a protocol for defining objects that can be bound to a view model.
 */
protocol ViewModelBindable {
    func bind(to viewModel:ViewModel)
}

