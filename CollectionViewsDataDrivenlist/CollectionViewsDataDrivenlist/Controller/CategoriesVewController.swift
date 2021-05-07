//
//  CategoriesViewController.swift
//  CollectionViews_DataDrivenList
//
//  Created by Mospeng Research Lab Philippines on 4/24/20.
//  Copyright © 2020 Mospeng Research Lab Philippines. All rights reserved.
//

import UIKit

class CategoriesVewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var selectedData = SelectedData()
    var dataLoader = DataLoader()
    var categoriesData = [Categories]()
    

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
        layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
        
        categoriesData = dataLoader.getCategoriesData()
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCollectionViewCell
        cell.layer.borderColor = UIColor.placeholderText.cgColor
        cell.layer.borderWidth = 0.5
        cell.nameLbl.text = categoriesData[indexPath.row].category_name.capitalized
        cell.imageView.image = UIImage(named: categoriesData[indexPath.row].category_image)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedData.id = categoriesData[indexPath.row].category_id
        performSegue(withIdentifier: "subcategories", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let destination = segue.destination as? SubcategoriesViewController {
            destination.selectedData = selectedData
        }

    }
    
}
