//
//  MainVC
//  WishList
//
//  Created by Khoa on 1/20/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import UIKit
import CoreData
class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    var controller : NSFetchedResultsController<Item>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // generateData()
        attempFetch()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections{
            
            return sections.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections{
            print("HERE section")
            
            let sectionInfo = sections[section]
            print(sectionInfo.numberOfObjects)
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        configureCell(cell: cell, indexPath: indexPath)
        print(cell)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // REVIEW , vi ko co Item array nen phai xai cai khac
        
        if let objs = controller.fetchedObjects, objs.count > 0{
            let item = objs[indexPath.row]
            performSegue(withIdentifier: "ItemDetailVC", sender: item)
        }
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let itemDetailVC = segue.destination as? ItemDetails{
            if let item = sender as? Item{
                itemDetailVC.editItem = item
            }
        }
    }
    
    
    func configureCell( cell : ItemCell, indexPath : IndexPath ){
        let item = controller.object(at: indexPath)
        cell.configureCell(item: item)
    }
    
    
    func attempFetch(){
        
        let fetchRequest : NSFetchRequest<Item> = Item.fetchRequest()
        
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        let priceSort = NSSortDescriptor(key: "price", ascending: false)
        let titleSort = NSSortDescriptor(key: "title", ascending: true)
        
        

        
        if segment.selectedSegmentIndex == 0 {
             fetchRequest.sortDescriptors = [dateSort]
        }else if segment.selectedSegmentIndex == 1 {
             fetchRequest.sortDescriptors = [priceSort]
        }else if segment.selectedSegmentIndex == 2 {
            fetchRequest.sortDescriptors = [titleSort]
        }
        
       
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)

        // REVIEW : Why self.delegate doesn't work???
        controller.delegate = self
        
        self.controller = controller
        
        
        do {
            try controller.performFetch()
        }
        catch{
            print(error)
        }
    
        
    }
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
       
        
        switch type {
            
        case .insert:
            print("I'm inserting")
            if let indexPath = newIndexPath{
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            
            break
        case .update:
            if let indexPath = indexPath{
                let cell = tableView.cellForRow(at: indexPath) as! ItemCell
                configureCell(cell: cell, indexPath: indexPath)
                
            }
            break
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case .move:
            
            // delete now - add new
            if let indexPath = indexPath{
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let newIndexPath = newIndexPath{
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
            
            break
        
        }
        
    }
    
    func generateData(){
        
        let item = Item(context: context)
        item.title = "Tesla Model S"
        item.details = "I  really like electic and auto drive car. Hope to buy it before I turn 25"
        item.price = 100000
        
        
        let item2 = Item(context: context)
        item2.title = "Standup Table"
        item2.details = "I like to stand to code in the future"
        item2.price = 250
        
        let item3 = Item(context: context)
        item3.title = "AirBlade"
        item3.details = "I want to travel alone with this bicyle"
        item3.price = 2000
        
        
        
        // REVIEW : difference ad.saveContext vs try context.save()
        ad.saveContext()
        
    }
    
    
    @IBAction func segmentChanged(_ sender: Any) {
        
        print(segment.selectedSegmentIndex)
        attempFetch()
        
        tableView.reloadData()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    



}

