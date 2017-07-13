//
//  IDataConsumer.swift
//  OFS_Stella
//
//  Created by William Izzo on 13/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation

/**
 * Protocol defining an interface for object that needs to consume data
 * troughout a data provider.
 */
protocol IDataConsumer {
    /// The underlying data provider from where consumer will get its data.
    var dataProvider : IDataProvider! { get }
    /// Retrieves data from the consumer's data provider.
    func consumeData()
}
