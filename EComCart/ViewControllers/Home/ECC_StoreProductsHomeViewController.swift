//
//  ViewController.swift
//  EComCart
//
//  Created by mytsl01831 on 27/04/22.
//

import UIKit

class ECC_StoreProductsHomeViewController: UIViewController {

    
    let dataService = ECC_DataServices()
    
    var stores : [ECC_StoreInfoModel]?
    var products : [ECC_ProductsModel]?
    //var masterProducts : [ECC_ProductsModel]?

    @IBOutlet weak var storeCollectionView: UICollectionView!
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var summaryScreenButton: UIButton!

    
     let storeCellIdentifier = "storeCell"
     let productCellIdentifier = "productCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        stores = dataService.getStore()
        summaryScreenButton.layer.borderWidth = 5.0
        summaryScreenButton.layer.borderColor = UIColor.white.cgColor
        summaryScreenButton.layer.cornerRadius = 5.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateStoreData()
    }

    func updateStoreData(){
        if(ECC_CartManager.shared.totalProductCount() > 0){
            self.summaryScreenButton.setTitle("\(OrderSummary) (Item Added : \(ECC_CartManager.shared.totalProductCount()))", for: .normal)
            self.summaryScreenButton.isEnabled = true
        }else{
            self.summaryScreenButton.setTitle(OrderSummary, for: .normal)
            self.summaryScreenButton.isEnabled =  false
        }
        
        products = dataService.getTheUpdatedProductsIfProductCartUpdated()
        storeCollectionView.reloadData()
        productCollectionView.reloadData()
    }

}

extension ECC_StoreProductsHomeViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == self.storeCollectionView){
            return stores?.count ?? 0
        }else{
            return products?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == self.storeCollectionView){
            //store cell display
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: storeCellIdentifier, for: indexPath) as! ECC_StoreCollectionViewCell
            
            if let storeModel = stores?[indexPath.row]
            {
                cell.cellViewModel = storeModel
            }
            return cell
           
        }else{
            //Product Cell display
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCellIdentifier, for: indexPath) as! ECC_ProductCollectionViewCell
            
            if let productModel = products?[indexPath.row]
            {
                cell.cellViewModel = productModel
            }
            cell.indexPath = indexPath
            cell.cellDelegate = self
            return cell
        }
    }
}

extension ECC_StoreProductsHomeViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if (collectionView == self.storeCollectionView){
            return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height-10)
        }else{
            return CGSize(width: (collectionView.frame.width/2)-10, height: (collectionView.frame.height/2)-10)
        }
    }
}

extension ECC_StoreProductsHomeViewController : ECC_ProductCollectionViewCellDelegate{
    func addProductToCartDelegate(productCell: ECC_ProductCollectionViewCell, product: ECC_ProductsModel, shouldAdd: Bool, indexPath: IndexPath) {
        if(shouldAdd){
            //Removing the
            var productNew = product
            productNew.isSelected = true
            products?[indexPath.row] = productNew
            
            ECC_CartManager.shared.addProduct(productNeedToAdd: productNew)
        }else{
            var productNew = product
            productNew.isSelected = false
            products?[indexPath.row] = productNew

            ECC_CartManager.shared.removeProduct(productNeedToRemove: productNew)
        }
        
        DispatchQueue.main.async() {
            //Update the enable disable of order summary button
            self.updateStoreData()
        }
    }

}
