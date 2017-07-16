//
//  DetailView.swift
//  OFS_Stella
//
//  Created by William Izzo on 16/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import UIKit

class DetailView: UIView, DataBindable {
    @IBOutlet var imageView : UIImageView!
    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var subheadingLabel : UILabel!
    @IBOutlet var subtitleLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = Fonts.title.get()
        subtitleLabel.font = Fonts.headline.get()
        subheadingLabel.font = Fonts.macrocategory.get()
    }
    
    func bind(to presenter: Presenter) {
        let detailPresenter = presenter as! DetailViewPresenter
        titleLabel.text = detailPresenter.title
        subtitleLabel.text = detailPresenter.subtitle
        subheadingLabel.text = detailPresenter.subhead
        _ = 
        AppServices
            .imagesProvider
            .retrieveData(request: detailPresenter.imageRequest) { image, error in
                DispatchQueue.main.async { [weak self] in
                    self?.imageView.image = image
                }
        }
    }
}
