//
//  ProductTableViewCell.swift
//  OFS_Stella
//
//  Created by William Izzo on 15/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import UIKit

/**
 * A used to display products.
 */
class ProductTableViewCell: UITableViewCell, ViewModelBindable {
    /// Label that displays product's name.
    @IBOutlet var nameLabel : UILabel!
    
    /// Label that displays product's price label.
    @IBOutlet var priceLabel : UILabel!
    
    /// Image view containing product's thumbnail image.
    @IBOutlet var thumbnailImageView : UIImageView!
    
    /// Thumbnail image is loaded from the images provider: this variable
    /// contains the token identifier of the current request. This is used so
    /// that when cell gets reused, the implementation has a chance to cancel
    /// a previous load request.
    private var currentRetrieveDataRequest : DataProviderToken?
    
    /// A reference to the shared images provider
    /// - SeeAlso: ProductImagesProvider
    private let imagesProvider = AppServices.imagesProvider
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.font = Fonts.body.get()
        priceLabel.font = Fonts.headline.get()
    }
    
    deinit {
        guard let currentImageTask = currentRetrieveDataRequest else {
            return
        }
        imagesProvider.cancelRequest(token: currentImageTask)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        thumbnailImageView.image = AppImages.placeholder.get()
        guard let currentImageTask = currentRetrieveDataRequest else {
            return
        }
        imagesProvider.cancelRequest(token: currentImageTask)
    }
    
    func bind(to presenter: ViewModel) {
        let productCellPresenter = presenter as! ProductCellViewModelInterface
        nameLabel.text = productCellPresenter.name
        priceLabel.text = productCellPresenter.price
        currentRetrieveDataRequest = imagesProvider
            .requestData(request: productCellPresenter.imageRequest) { image, error in
                DispatchQueue.main.async { [weak self] in 
                    self?.thumbnailImageView.image = image
                }
        }
    }
}
