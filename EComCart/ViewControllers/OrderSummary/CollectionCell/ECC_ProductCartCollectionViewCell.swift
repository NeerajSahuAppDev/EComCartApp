//
//  ECC_ProductCartCollectionViewCell.swift
//  EComCart
//
//  Created by mytsl01831 on 29/04/22.
//

import UIKit
protocol ECC_ProductCartCollectionViewCellDelegate: AnyObject {
    func removeProductCartDelegate(productCell: ECC_ProductCartCollectionViewCell, product :ECC_ProductsModel, shouldAdd : Bool)
}

class ECC_ProductCartCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addToCart: UIButton!
    

    weak var cellDelegate: ECC_ProductCartCollectionViewCellDelegate?

    var cellViewModel: ECC_ProductsModel? {
        didSet {
            productTitleLabel.text = cellViewModel?.title
            productImageView.image = UIImage.init(named: cellViewModel?.image ?? "0")
            priceLabel.text = "Price: \(cellViewModel?.price ?? 0) " + RupeeSymbol
        }
    }
    @IBAction func removeProductFromCartAction(_ sender: Any) {
        //Calling a delegate Function
        cellDelegate?.removeProductCartDelegate(productCell: self ,product :cellViewModel! ,shouldAdd: false)
        cellViewModel?.isSelected = false
        self.isSelected = false
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        productTitleLabel.text = nil
        productImageView.image = nil
        priceLabel.text = nil
    }
    
}

