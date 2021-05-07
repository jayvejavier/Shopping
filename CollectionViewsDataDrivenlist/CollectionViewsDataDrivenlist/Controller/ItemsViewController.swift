//
//  ItemsViewController.swift
//  CollectionViews_DataDrivenList
//
//  Created by Mospeng Research Lab Philippines on 4/27/20.
//  Copyright © 2020 Mospeng Research Lab Philippines. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var selectedData = SelectedData()
    var dataLoader = DataLoader()
    var itemsData = [Items]()
    var newItemsData = [Any]()

    @IBOutlet weak var collectionView: UICollectionView!
    
    var screenWidth: CGFloat!
    var screenSize: CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Do any additional setup after loading the view.
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/2, height: screenWidth/2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
        
        for id in selectedData.ids {
            itemsData = dataLoader.getItemsData(from_subcategory_id: id)
            newItemsData.append(contentsOf: itemsData)
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newItemsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCollectionViewCell
        cell.layer.borderColor = UIColor.placeholderText.cgColor
        cell.layer.borderWidth = 0.5
        let items = newItemsData[indexPath.row] as! Items
        cell.nameLbl.text = String("  \(items.item_name.capitalized)")
        cell.imageView.image = UIImage(named: items.item_image)
        cell.priceLbl.text = String("  ₱ \(items.item_price)")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let items = newItemsData[indexPath.row] as! Items
        
        selectedData.id = items.item_id
        selectedData.name = items.item_name.capitalized
        selectedData.image_str = items.item_image
        selectedData.price = items.item_price
        selectedData.description = items.item_description
        
        performSegue(withIdentifier: "details", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? DetailsViewController {
            destination.selectedData = selectedData
        }
        
    }
    
}
