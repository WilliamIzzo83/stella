//
//  IDataModel.swift
//  OFS_Stella
//
//  Created by William Izzo on 13/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation

/**
 * Defines application's data model interface. Each model has an identifier
 * that allows fast type inference.
 */
protocol IDataModel {
    /// Data model's type.
    static var type : Int { get }
}
