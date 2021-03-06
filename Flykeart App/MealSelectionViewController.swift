//
//  MealSelectionViewController.swift
//  Flykeart App
//
//  Created by Federico Brandt on 4/25/19.
//  Copyright © 2019 Federico Brandt. All rights reserved.
//

import UIKit

class MealSelectionViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var seatLabel: UILabel!
    
    @IBOutlet weak var drinkCollectionView: UICollectionView!
    @IBOutlet weak var snackCollectionView: UICollectionView!
    
    let drinks = ["Water","Coke","Diet Coke","Coke Zero","Sprite","Orange Juice","Apple Juice","None"]
    let drinkImages: [UIImage] = [
        UIImage(named: "Water")!,
        UIImage(named: "Coke")!,
        UIImage(named: "DietCoke")!,
        UIImage(named: "CokeZero")!,
        UIImage(named: "Sprite")!,
        UIImage(named: "OrangeJuice")!,
        UIImage(named: "AppleJuice")!,
        UIImage(named: "None")!
    ]
    
    let snacks = ["Peanuts","Biscuits","Oreos","Cashews","Pretzels","Chocolate","None"]
    let snackImages: [UIImage] = [
        UIImage(named: "Peanuts")!,
        UIImage(named: "Biscuits")!,
        UIImage(named: "Oreos")!,
        UIImage(named: "Cashews")!,
        UIImage(named: "Pretzels")!,
        UIImage(named: "Chocolate")!,
        UIImage(named: "None")!
    ]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == drinkCollectionView{
            return drinks.count
        }
        else{
            return snacks.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == drinkCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "drinkCell", for: indexPath) as! DrinkCollectionViewCell
            cell.drinkLabel.text = drinks[indexPath.item]
            cell.drinkImage.image = drinkImages[indexPath.item]
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.borderWidth = 0.5
            cell.layer.cornerRadius = 10
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "snackCell", for: indexPath) as! SnackCollectionViewCell
            cell.snackLabel.text = snacks[indexPath.item]
            cell.snackImage.image = snackImages[indexPath.item]
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.borderWidth = 0.5
            cell.layer.cornerRadius = 10
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == drinkCollectionView{
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.layer.borderColor = UIColor.green.cgColor
            cell?.layer.borderWidth = 2
            cell?.layer.cornerRadius = 10
            self.selectedDrink = drinks[indexPath.item]
        }
        else {
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.layer.borderColor = UIColor.green.cgColor
            cell?.layer.borderWidth = 2
            cell?.layer.cornerRadius = 10
            self.selectedSnack = snacks[indexPath.item]
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == drinkCollectionView{
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.layer.borderColor = UIColor.lightGray.cgColor
            cell?.layer.borderWidth = 0.5
            cell?.layer.cornerRadius = 10
        }
        else {
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.layer.borderColor = UIColor.lightGray.cgColor
            cell?.layer.borderWidth = 0.5
            cell?.layer.cornerRadius = 10
        }
    }
    
    //Submit Order Button
    
    @IBAction func submitOrder(_ sender: Any) {
        FirebaseClient.uploadMenuSelection(seat: self.seat, name: self.name, snack: self.selectedSnack, drink: self.selectedDrink)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func goBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var selectedDrink : String = ""
    var selectedSnack : String = ""
    
    //Get Seat From first Window
    var name: String = ""
    var seat: String = ""
    
    var snackChoice: String = ""
    var drinkChoice: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get Info from first screen
        nameLabel.text = name
        seatLabel.text = seat
        
        self.drinkCollectionView.delegate = self
        self.drinkCollectionView.dataSource = self
        self.snackCollectionView.delegate = self
        self.snackCollectionView.dataSource = self
        
        var layout1 = self.drinkCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        var layout2 = self.snackCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        let width = (view.frame.size.width - 20) / 3
        
        layout1.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout2.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        layout1.minimumInteritemSpacing = 5
        layout2.minimumInteritemSpacing = 5
        
        layout1.itemSize = CGSize(width: width, height: width)
        layout2.itemSize = CGSize(width: width, height: width)
        
        //Initiate Labels
        selectedDrink = ""
        selectedSnack = ""
    }
    

}
