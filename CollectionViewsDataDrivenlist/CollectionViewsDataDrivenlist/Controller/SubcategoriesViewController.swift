//
//  SubcategoriesViewController.swift
//  CollectionViews_DataDrivenList
//
//  Created by Mospeng Research Lab Philippines on 4/25/20.
//  Copyright © 2020 Mospeng Research Lab Philippines. All rights reserved.
//

import UIKit

class SubcategoriesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var selectedData = SelectedData()
    var dataLoader = DataLoader()
    var subcategoriesData = [Subcategories]()
    
    var arrSelectedIndex = [IndexPath]() // This is selected cell Index array
    var arrSelectedData = [Int]() // This is selected cell data array
    
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
        
        subcategoriesData = dataLoader.getSubcategoriesData(from_category_id: selectedData.id)
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subcategoriesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCollectionViewCell
        cell.layer.borderColor = UIColor.placeholderText.cgColor
        cell.layer.borderWidth = 0.5
        cell.nameLbl.text = subcategoriesData[indexPath.row].subcategory_name.capitalized
        cell.imageView.image = UIImage(named: subcategoriesData[indexPath.row].subcategory_image)

        
        if arrSelectedIndex.contains(indexPath) { // You need to check wether selected index array contain current index if yes then change the color
            cell.plusImg.tintColor = UIColor(hue: 0.50, saturation: 0.75, brightness: 0.75, alpha: 1)
        }
        else {
            cell.plusImg.tintColor = UIColor.lightGray
        }
        
        cell.layoutSubviews()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("You selected cell #\(indexPath.item)!")

        let intData = subcategoriesData[indexPath.row].subcategory_id

        if arrSelectedIndex.contains(indexPath) {
            arrSelectedIndex = arrSelectedIndex.filter { $0 != indexPath}
            arrSelectedData = arrSelectedData.filter { $0 != intData}
        }
        else {
            arrSelectedIndex.append(indexPath)
            arrSelectedData.append(intData)
        }
        selectedData.ids = arrSelectedData
        
        collectionView.reloadData()
    }

    
    @IBAction func continueBtnTapped(_ sender: Any) {
        if arrSelectedData.isEmpty {
            showAlert()
        }
        else {
            performSegue(withIdentifier: "items", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ItemsViewController {
            destination.selectedData = selectedData
        }
    }
    
    func showAlert() {
       
       // Creating alert view
       
       let alertView = UIAlertController(title: "Message", message: "Please select one or more items you are interested in.", preferredStyle: .alert)
       alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
           
//           print("Done button was pressed")
       }))
       
       // Present alert view
       
       self.present(alertView, animated: true, completion: nil)
   }
    
}
