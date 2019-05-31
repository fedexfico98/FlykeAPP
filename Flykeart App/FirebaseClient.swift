//
//  FirebaseClient.swift
//  Flykeart App
//
//  Created by Akhil Pothana on 5/28/19.
//  Copyright © 2019 Federico Brandt. All rights reserved.
//
// A singleton for performing all interactions with Firebase

import Foundation
import FirebaseDatabase

struct FirebaseClient {
    
    static let currentOrdersRef = Database.database().reference().child("CurrentOrders")
    
    static func uploadMenuSelection(seat: String, name: String, snack: String, drink: String) {
        
        let orderItem = ["seat" : seat, "name" : name, "snack" : snack, "drink" : drink] as [String : Any]
        
        currentOrdersRef.child("seat-\(seat)").updateChildValues(orderItem) { (error, ref) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            print(ref.child("seat"))
        }
    }
    
    // Download the current list of orders as a dictionary
    // With .observer, we are listening for new orders so the Flight attendant
    // view is automatically updated
    static func getNewOrders(completion : @escaping (Order?) -> ()) -> Void {
        
        //MARK: - LISTENERS FIREBASE
        
        currentOrdersRef.observe(.childAdded, with: { (snapshot) in
            let postDict = snapshot.value as! [String : String]
            
            let order = Order(orderItems: postDict)
            completion(order)
        })
    }
    
    // Delete an order from the list
    static func deleteOrder(seatNumber : String) {
        currentOrdersRef.child("seat-\(seatNumber)").removeValue()
    }
}
