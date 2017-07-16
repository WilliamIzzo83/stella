//
//  DetailViewPresenter.swift
//  OFS_Stella
//
//  Created by William Izzo on 16/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation

protocol DetailViewPresenter : Presenter {
    var title : String { get }
    var subtitle : String { get }
    var subhead : String { get }
    var imageRequest : ImageRequest { get }
}
