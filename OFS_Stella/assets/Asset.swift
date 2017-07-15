//
//  Asset.swift
//  OFS_Stella
//
//  Created by William Izzo on 14/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation

protocol Asset {
    associatedtype T
    func get() -> T
}
