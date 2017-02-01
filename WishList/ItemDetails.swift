//
//  ItemDetails.swift
//  WishList
//
//  Created by Khoa on 2/1/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import UIKit
import CoreData
class ItemDetails: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var detailTF: UITextField!
    @IBOutlet weak var priceTF: UITextField!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var itemImage: UIImageView!
    
    var stores = [Store]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topBar = self.navigationController?.navigationBar.topItem{
           topBar.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        
//        let store1 = Store(context: context)
//        store1.name = "Lazada"
//        
//        let store2 = Store(context: context)
//        store2.name = "Sendo"
//        
//        let store3 = Store(context: context)
//        store3.name = "Tiki"
//        
//        let store4 = Store(context: context)
//        store4.name = "5s"
//        
//        let store5 = Store(context: context)
//        store5.name = "Prazenta"
//        
//        
//        ad.saveContext()
        getStores()
        
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stores[row].name
    }
    
    
    func getStores(){
        
        let fetchRequest : NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            
            try self.stores = context.fetch(fetchRequest)
            
        }catch{
            
        }
        pickerView.reloadAllComponents()
        
    }
    
    
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        guard let title = titleTF.text, title != "" else {
            return
        }
        guard let price = priceTF.text  else {
            return
        }
        guard let detail = detailTF.text, detail != "" else {
            return
        }
        
        
        let item = Item(context: context)
        
        item.title = title
        item.price = Float(( price as NSString ).doubleValue)
        item.details = detail
        
        item.
        
        ad.saveContext()
        
        
       _ = self.navigationController?.popViewController(animated: true)
        
        
        
        
        
        
        
        
        
    }
    
    

}
