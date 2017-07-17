//
//  DepartmentTableViewCell.swift
//  OFS_Stella
//
//  Created by William Izzo on 15/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import UIKit

/**
 * Cell used to display categories.
 */
class CategoryTableViewCell: UITableViewCell, ViewModelBindable {
    /// Label that displays category's title
    @IBOutlet var titleLabel : UILabel!
    /// Image view containing category image.
    @IBOutlet var backgroundImageView : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = Fonts.body.get()
    }
    
    func bind(to presenter: ViewModel) {
        let cellPresenter = presenter as! CategoryCellViewModelInterface
        titleLabel.text = cellPresenter.title
        backgroundImageView.image = cellPresenter.image
    }

}
