//
//  ItemDetails.swift
//  WishList
//
//  Created by Khoa on 2/1/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import UIKit
import CoreData
class ItemDetails: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource,
UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var detailTF: UITextField!
    @IBOutlet weak var priceTF: UITextField!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var itemImage: UIImageView!
    
    var imagePicker : UIImagePickerController!
    var editItem : Item?
    var stores = [Store]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topBar = self.navigationController?.navigationBar.topItem{
           topBar.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        getStores()
        
        if let item = editItem{
            
            titleTF.text = item.title
            priceTF.text = "\(item.price)"
            detailTF.text = item.details
            
            itemImage.image = item.toImage?.image as? UIImage
            
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
        
        let picture = Image(context: context)
        
        picture.image = itemImage.image
        
        if editItem != nil{
            
            // REVIEW : Why coredata can do this? -> Reference type when prepareSegue
            item = editItem
            
        }else {
            item = Item(context: context)
        }
        
        item.toImage = picture
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
    
    @IBAction func deletePressed(_ sender: Any) {
        if editItem != nil{
            
            context.delete(editItem!)
            ad.saveContext()
        }
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func chooseImagePressed(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage{
            itemImage.image = img
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
}
