//
//  ProductTableViewCell.swift
//  OFS_Stella
//
//  Created by William Izzo on 15/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell, DataBindable {
    @IBOutlet var nameLabel : UILabel!
    @IBOutlet var priceLabel : UILabel!
    @IBOutlet var thumbnailImageView : UIImageView!
    private var currentRetrieveDataRequest : DataProviderToken?
    private var imagesProvider = AppServices.imagesProvider
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
        thumbnailImageView.image = nil
        guard let currentImageTask = currentRetrieveDataRequest else {
            return
        }
        imagesProvider.cancelRequest(token: currentImageTask)
    }
    
    func bind(to presenter: Presenter) {
        let productCellPresenter = presenter as! ProductCellPresenter
        nameLabel.text = productCellPresenter.name
        priceLabel.text = productCellPresenter.price
        currentRetrieveDataRequest = imagesProvider
            .retrieveData(request: productCellPresenter.imageRequest) { image, error in
                DispatchQueue.main.async { [weak self] in 
                    self?.thumbnailImageView.image = image
                }
        }
    }
}
