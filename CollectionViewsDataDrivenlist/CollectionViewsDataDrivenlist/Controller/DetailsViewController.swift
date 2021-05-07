//
//  DetailsViewController.swift
//  CollectionViews_DataDrivenList
//
//  Created by Mospeng Research Lab Philippines on 4/28/20.
//  Copyright © 2020 Mospeng Research Lab Philippines. All rights reserved.
//

import UIKit

var purchasesData = PurchasesData()

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var buyBtn: UIButton!
    
    var selectedData = SelectedData()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buyBtn.layer.cornerRadius = 25.0
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 1

        // Do any additional setup after loading the view.
        
        imageView.image = UIImage(named: selectedData.image_str)
        nameLbl.text = selectedData.name
        priceLbl.text = String("₱ \(selectedData.price)")
        descriptionLbl.text = selectedData.description
    
    }
    
    @IBAction func buyBtnTapped(_ sender: Any) {
        
        purchasesData.purchasePrices.append(selectedData.price)
        UserDefaults.standard.set(purchasesData.purchasePrices, forKey: "purchasePrices")
        print(purchasesData.purchasePrices)
        
        showAlert(message: String("Item successfully purchased."))
    }
    
    func showAlert(message: String) {
           
       // Creating alert view
       
       let alertView = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
       alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
           
//           print("Done button was pressed")
       }))
       
       // Present alert view
       
       self.present(alertView, animated: true, completion: nil)
   }
    
    
}
