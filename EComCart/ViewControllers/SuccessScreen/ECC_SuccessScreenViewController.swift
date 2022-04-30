//
//  ECC_SuccessScreenViewController.swift
//  EComCart
//
//  Created by mytsl01831 on 29/04/22.
//

import UIKit

class ECC_SuccessScreenViewController: UIViewController {

    //var spinner = UIActivityIndicatorView(style: .whiteLarge)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func continueShoppingAction(_ sender: Any) {
        
        self.navigationController?.popToRootViewController(animated: true)
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
