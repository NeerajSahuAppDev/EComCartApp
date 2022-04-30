//
//  ECC_StoreCollectionViewCell.swift
//  EComCart
//
//  Created by mytsl01831 on 29/04/22.
//

import UIKit

class ECC_StoreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var storeTitleLabel: UILabel!
    @IBOutlet weak var storeImageView: UIImageView!
    
    
    var cellViewModel: ECC_StoreInfoModel? {
        didSet {
            storeTitleLabel.text = cellViewModel?.title
            storeImageView.image = UIImage.init(named: cellViewModel?.image ?? "0.jpg")
            self.layer.cornerRadius = 10.0
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        storeTitleLabel.text = nil
        storeImageView.image = nil
    }
    
    override var isSelected: Bool {
        didSet{
            if self.isSelected {

                self.layer.borderColor = UIColor.systemPink.cgColor
                self.layer.borderWidth = 5.0
            }
            else {
                self.layer.borderColor = nil
                self.layer.borderWidth = 0.0
            }
        }
    }
}
