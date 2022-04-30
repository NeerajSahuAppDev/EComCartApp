//
//  ECC_ProductCollectionViewCell.swift
//  EComCart
//
//  Created by mytsl01831 on 29/04/22.
//

import UIKit
protocol ECC_ProductCollectionViewCellDelegate: AnyObject {
    func addProductToCartDelegate(productCell: ECC_ProductCollectionViewCell, product :ECC_ProductsModel, shouldAdd : Bool, indexPath: IndexPath)
}

class ECC_ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var addToCart: UIButton!

    weak var cellDelegate: ECC_ProductCollectionViewCellDelegate?
    var indexPath : IndexPath?
    
    var cellViewModel: ECC_ProductsModel? {
        didSet {
            productTitleLabel.text = cellViewModel?.title
            productImageView.image = UIImage.init(named: cellViewModel?.image ?? "0")
            priceLabel.text = "Price: \(cellViewModel?.price ?? 0)" + "\u{20B9}"
            ratingLabel.text = "Rating: \(cellViewModel?.rating ?? 4.5) "
            if let isSelected = cellViewModel?.isSelected {
                if(isSelected == true){
                    let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
                    let selectedImage = UIImage(systemName: "checkmark.circle.fill", withConfiguration: boldConfig)
                    addToCart.setImage(selectedImage, for: .normal)
                }else{
                    let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
                    let cartImage = UIImage(systemName: "cart.badge.plus", withConfiguration: boldConfig)
                    addToCart.setImage(cartImage, for: .normal)
                }
            }
            self.layer.cornerRadius = 10.0
        }
    }
    @IBAction func addToCartAction(_ sender: Any) {
        if let isSelected = cellViewModel?.isSelected , let cellIndexPath = indexPath{
            if(isSelected == true){
                cellDelegate?.addProductToCartDelegate(productCell: self ,product :cellViewModel! ,shouldAdd: false, indexPath: cellIndexPath)
                cellViewModel?.isSelected = false
                self.isSelected = false
            }else{
                cellDelegate?.addProductToCartDelegate(productCell: self ,product :cellViewModel! ,shouldAdd: true, indexPath: cellIndexPath)
                cellViewModel?.isSelected = true
                self.isSelected = true
            }
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        productTitleLabel.text = nil
        productImageView.image = nil
        priceLabel.text = nil
        ratingLabel.text = nil
        
    }
}
