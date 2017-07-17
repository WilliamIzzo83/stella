//
//  Asset.swift
//  OFS_Stella
//
//  Created by William Izzo on 14/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation

/**
 * Defines an interface for classes that exposes asset used during applicaiton
 * lifecycle. An asset may be a string, a static image, a font so on and so
 * forth
 */
protocol Asset {
    /// Defines the asset type.
    associatedtype T
    /// Gets an asset.
    func get() -> T
}
