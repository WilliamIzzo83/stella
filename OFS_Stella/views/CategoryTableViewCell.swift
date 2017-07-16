//
//  DepartmentTableViewCell.swift
//  OFS_Stella
//
//  Created by William Izzo on 15/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell, DataBindable {
    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var backgroundImageView : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = Fonts.body.get()
    }
    
    func bind(to presenter: Presenter) {
        let cellPresenter = presenter as! CategoryCellPresenter
        titleLabel.text = cellPresenter.title
        backgroundImageView.image = cellPresenter.image
    }

}
