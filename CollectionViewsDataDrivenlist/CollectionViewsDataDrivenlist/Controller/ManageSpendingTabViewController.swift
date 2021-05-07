//
//  ManageSpendingTabViewController.swift
//  MoneyTree
//
//  Created by Mospeng Research Lab Philippines on 4/30/20.
//  Copyright © 2020 Mospeng Research Lab Philippines. All rights reserved.
//

import UIKit

class ManageSpendingTabViewController: UIViewController {
    
    @IBAction func goToShopBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "categories", sender: self)
    }

}

