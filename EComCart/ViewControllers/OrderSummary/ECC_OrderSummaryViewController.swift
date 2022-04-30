//
//  ECC_OrderSummaryViewController.swift
//  EComCart
//
//  Created by mytsl01831 on 29/04/22.
//

import UIKit

class ECC_OrderSummaryViewController: UIViewController {

    @IBOutlet weak var addressDetailsTextView: UITextView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var totalItemsLabel: UILabel!
    @IBOutlet weak var productCollectionView: UICollectionView!

    
    let dataService = ECC_DataServices()
    var products : [ECC_ProductsModel]?
    var orderDoneDetails : ECC_OrderDoneModel?
    let childViewSpinner = ECC_SpinnerViewController()

    let productCellIdentifier = "productCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        products = ECC_CartManager.shared.productCart
        addressDetailsTextView.delegate = self
        orderDoneDetails =  dataService.getOrderDoneDetails()
        orderDoneDetails?.orderData = products
        
        updateData()
    }
    
    func updateData(){
        self.totalItemsLabel.text = "\(TotalItems): \(products?.count ?? 0)"
        let totalPrice = String(format: "%.2f", ECC_CartManager.shared.totalCartPriceValue())
        self.totalPriceLabel.text = "\(TotalPrice): \(totalPrice))" + RupeeSymbol
        
        orderDoneDetails?.orderPrice = totalPrice
        productCollectionView.reloadData()
    }
    
    //Confirm order details method will be able to create the json file from datamodel
    @IBAction func confirmOrderAction(_ sender: Any) {
        
        if(self.addressDetailsTextView.text == ""){
            //if shiping address is not present
            showAlert(title: AlertTitle, message: AlertMessage)
        }else{
            createSpinnerView()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.postOrderDetails()
            })
        }
    }
    func postOrderDetails(){
        if let orderDetail = orderDoneDetails{
            ECC_CartManager.shared.postOrderDetailsToLocalDocumentFolder(orderDoneDetails: orderDetail) { success in
                
                if(success){
                    //remove activity progress
                    removeSpinner()
                    //First Clear the cart
                    ECC_CartManager.shared.clearCart()
                    //Then move to Success Screen
                    moveToSuccessScreen()
                }else{
                    //If Save operation get failed then show an alert
                    showAlert(title: OrderFailAlertTitle, message: OrderFailAlertMessage)
                }
            }
        }
    }
    //move To Success Screen
    func moveToSuccessScreen(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let successScreenViewController = storyBoard.instantiateViewController(withIdentifier: "ECC_SuccessScreenViewController") as! ECC_SuccessScreenViewController
        self.navigationController?.show(successScreenViewController, sender: self)
    }
    func showAlert(title: String, message: String){
        // Create a new alert
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
         })
        
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)
        // Present alert to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    func createSpinnerView() {

        // add the spinner view controller
        addChild(childViewSpinner)
        childViewSpinner.view.frame = view.frame
        view.addSubview(childViewSpinner.view)
        childViewSpinner.didMove(toParent: self)
    }
    
    func removeSpinner(){
        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // then remove the spinner view controller
            self.childViewSpinner.willMove(toParent: nil)
            self.childViewSpinner.view.removeFromSuperview()
            self.childViewSpinner.removeFromParent()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension ECC_OrderSummaryViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCellIdentifier, for: indexPath) as! ECC_ProductCartCollectionViewCell
            
            if let productModel = products?[indexPath.row]
            {
                cell.cellViewModel = productModel
            }
            cell.cellDelegate = self

            return cell
    }
    
}

extension ECC_OrderSummaryViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: (collectionView.frame.width)-10, height: (collectionView.frame.height/5))
    }
}

extension ECC_OrderSummaryViewController : UITextViewDelegate{
    func textViewDidEndEditing(_ textView: UITextView) {
        orderDoneDetails?.shipments = textView.text
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if(text == "\n") {
                textView.resignFirstResponder()
                return false
            }
            return true
    }
}

extension ECC_OrderSummaryViewController : ECC_ProductCartCollectionViewCellDelegate{
    func removeProductCartDelegate(productCell: ECC_ProductCartCollectionViewCell, product: ECC_ProductsModel, shouldAdd: Bool) {
        ECC_CartManager.shared.removeProduct(productNeedToRemove: product)
        products?.removeAll(where: {$0.id == product.id})
        
        orderDoneDetails?.orderData = products
        DispatchQueue.main.async() {
            //Update the enable disable of order summary button
            //self.productCollectionView.reloadData()
            self.updateData()

        }
    }
}


