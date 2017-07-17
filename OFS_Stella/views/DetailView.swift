//
//  DetailView.swift
//  OFS_Stella
//
//  Created by William Izzo on 16/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import UIKit

/**
 * View used to show product's details.
 */
class DetailView: UIView, ViewModelBindable {
    /// Image view containing product's image.
    @IBOutlet var imageView : UIImageView!
    /// Label containing product's title.
    @IBOutlet var titleLabel : UILabel!
    /// Subheading label. Used to display a product's attribute.
    @IBOutlet var subheadingLabel : UILabel!
    /// Subheading label. Used to display a product's attribute.
    @IBOutlet var subtitleLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = Fonts.title.get()
        subtitleLabel.font = Fonts.headline.get()
        subheadingLabel.font = Fonts.macrocategory.get()
    }
    
    func bind(to presenter: ViewModel) {
        let detailPresenter = presenter as! DetailViewModelInterface
        titleLabel.text = detailPresenter.title
        subtitleLabel.text = detailPresenter.subtitle
        subheadingLabel.text = detailPresenter.subhead
        _ = 
        AppServices
            .imagesProvider
            .requestData(request: detailPresenter.imageRequest) { image, error in
                DispatchQueue.main.async { [weak self] in
                    self?.imageView.image = image
                }
        }
    }
}
