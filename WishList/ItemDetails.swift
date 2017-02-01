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
    
    var editItem : Item?
    var stores = [Store]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topBar = self.navigationController?.navigationBar.topItem{
           topBar.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        
        getStores()
        
        if let item = editItem{
            
            titleTF.text = item.title
            priceTF.text = "\(item.price)"
            detailTF.text = item.details
            
            if let itemStore = item.toStore{
                 var index = 0
                for store in stores{
                    
                    if store.name == itemStore.name{
                        pickerView.selectRow(index, inComponent: 0, animated: true)
                        break
                    }
                    index += 1
                    
                    
                }

            }
            
            
        }
        
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
            
            self.stores = try context.fetch(fetchRequest)
            self.pickerView.reloadAllComponents()
            
        }catch{
            
        }
        pickerView.reloadAllComponents()
        
    }
    
    
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        
        
        var item : Item!
        
        if editItem != nil{
            
            // REVIEW : Why coredata can do this? -> Reference type when prepareSegue
            item = editItem
            
        }else {
            item = Item(context: context)
        }
        
        
        guard let title = titleTF.text, title != "" else {
            return
        }
        guard let price = priceTF.text  else {
            return
        }
        guard let detail = detailTF.text, detail != "" else {
            return
        }
        
        
        item.title = title
        item.price = Float(( price as NSString ).doubleValue)
        item.details = detail
      
        item.toStore = stores[pickerView.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        
       _ = self.navigationController?.popViewController(animated: true)
        
        

        
    }
    
    

}
