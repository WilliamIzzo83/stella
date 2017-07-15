//
//  ViewModel.swift
//  OFS_Stella
//
//  Created by William Izzo on 15/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation
import UIKit


typealias ViewModelBindFunction<T> = (UIView, T) -> Void

/**
 * This descriptor defines a struct used by items list view controller used
 * to know how to bind data to a specific cell view.
 */
struct ViewModelBinderDescriptor<T> {
    /// Cell's reuse identifier for which the descriptor works.
    let cellReuseId : CellsIdentifiers
    /// Cell's bind function.
    let bind : ViewModelBindFunction<T>
}
