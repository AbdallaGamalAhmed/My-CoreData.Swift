//
//  ViewController.swift
//  Tutrial For Core Data
//
//  Created by Abdalla on 9/5/18.
//  Copyright © 2018 Abdalla. All rights reserved.
//

import UIKit
import CoreData

class Main_ViewController: UIViewController {
    
    @IBOutlet weak var ProductID_TF: UITextField!
    @IBOutlet weak var ProductName_TF: UITextField!
    @IBOutlet weak var ProductPrice_TF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectProducts()
    }
    
    @IBAction func InsertObject_Button(_ sender: UIButton) {
        
        inserNewProduct()
    }
    
    let fetchRequest : NSFetchRequest<Products_Entity> = Products_Entity.fetchRequest()
    
    
    // function To insert Data In CoreData
    func inserNewProduct()   {
        
        let Products_Let = NSEntityDescription.insertNewObject(forEntityName: "Products_Entity", into: context_Let) as! Products_Entity
        
        let id : Int32! = Int32(ProductPrice_TF.text!)
        let price : Double! = Double(ProductPrice_TF.text!)
        
        
        Products_Let.productId = id ?? 0
        Products_Let.productName = ProductName_TF.text ?? " "
        Products_Let.productPrice = price ?? 0.0
        
        do {
            context_Let.insert(Products_Let)
            try context_Let.save()
            print("Insert Saved")
            
        } catch let error {
            print(error)
        }
        
    }
    
    // function To Delet All Data from CoreData
    
    func deletAllProducts()  {
        
        let fetchRequest_Let : NSFetchRequest<Products_Entity> = Products_Entity.fetchRequest()
        
        let deletAllProducts_Let = NSBatchDeleteRequest(fetchRequest: fetchRequest_Let as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            try  context_Let.execute(deletAllProducts_Let )
            try context_Let.save()
        } catch let error {
            print(error)
        }
    }
    
    // function To Delete One Data From CoreData
    
    func deletOneProducts(id : Int32)  {
        let fetchRequest_Let : NSFetchRequest<Products_Entity> = Products_Entity.fetchRequest()
        
        let predicate_Let = NSPredicate(format: "productId='\(id)'")
        
        fetchRequest_Let.predicate = predicate_Let
        
        do {
            let results_Let = try context_Let.fetch(fetchRequest_Let)
            for result in results_Let {
                context_Let.delete(result)
            }
            // if i Sure that the product which will delete is one
            
            /*
             let oneRusult_let = results_Let.last
             context_Let.delete(oneRusult_let!)
             */
            
            try context_Let.save()
            
        } catch let error {
            print(error)
        }
    }
    
    // function to update Products in CoreData
    
    func UpdateProduct(id : Int32)  {
        
        let fetchRequest_Let : NSFetchRequest<Products_Entity> = Products_Entity.fetchRequest()
        
        let predicate_Let = NSPredicate(format: "productId='\(id)'")
        
        fetchRequest_Let.predicate = predicate_Let
        
        do {
            let results_Let = try context_Let.fetch(fetchRequest_Let)
            for result in results_Let {
                result.productId = 10
                result.productName = "IPhone"
                result.productPrice = 1.00
            }
            try context_Let.save()
            
        } catch let error {
            print(error)
        }
        
    }
    
    // function to Make Select
    
    func selectProducts()  {
        
        let fetchRequest_Let : NSFetchRequest<Products_Entity> = Products_Entity.fetchRequest()
        
        do {
            let results_Let = try context_Let.fetch(fetchRequest_Let)
            
            for result in results_Let {
                print(result.productId , " " , result.productName! , " " , result.productPrice)
            }
            
        } catch let error {
            print(error)
        }
    }
    
    // function if found Update if not found insert
    func foundUpdateElseInsert(id : Int32)  {
        
        let fetchRequest_Let : NSFetchRequest<Products_Entity> = Products_Entity.fetchRequest()
        
        let predicate_Let = NSPredicate(format: "productId='\(id)'")
        
        fetchRequest_Let.predicate = predicate_Let
        
        do {
            let results_Let = try context_Let.fetch(fetchRequest_Let)
            
            if results_Let.count != 0 {
                for result in results_Let {
                    result.productId = 10
                    result.productName = "IPhone"
                    result.productPrice = 1.00
                }
                try context_Let.save()
            }else{
                let Products_Let = NSEntityDescription.insertNewObject(forEntityName: "Products_Entity", into: context_Let) as! Products_Entity
                
                let id : Int32! = Int32(ProductPrice_TF.text!)
                let price : Double! = Double(ProductPrice_TF.text!)
                
                Products_Let.productId = id ?? 0
                Products_Let.productName = ProductName_TF.text ?? " "
                Products_Let.productPrice = price ?? 0.0
                
                do {
                    context_Let.insert(Products_Let)
                    try context_Let.save()
                    print("Insert Saved")
                    
                } catch let error {
                    print(error)
                }
            }
        } catch let error {
            print(error)
        }
    }
    
    // ------------- function to disappear the keyboard -------------
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

