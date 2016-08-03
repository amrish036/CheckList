//
//  ViewController.swift
//  CheckList
//
//  Created by Amrish Mahesh on 1/08/2016.
//  Copyright © 2016 Amrish Mahesh. All rights reserved.
//

import UIKit



class CheckListViewController: UITableViewController, ItemDetailViewControllerDelegate {
  
  
  func saveChecklistItems() {
    let data = NSMutableData()
    let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
    archiver.encodeObject(items, forKey: "ChecklistItems")
    archiver.finishEncoding()
    data.writeToFile(dataFilePath(), atomically: true)
  }
  
  func loadChecklistItems() {
    // 1
    let path = dataFilePath()
    // 2
    if NSFileManager.defaultManager().fileExistsAtPath(path) {
      // 3
      if let data = NSData(contentsOfFile: path) {
        let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
        items = unarchiver.decodeObjectForKey("ChecklistItems")
          as! [ChecklistItem]
        unarchiver.finishDecoding()
      }
    }
  }
  
  func documentsDirectory() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(
      .DocumentDirectory, .UserDomainMask, true)
    return paths[0]
  }
  func dataFilePath() -> String {
    return (documentsDirectory() as NSString)
      .stringByAppendingPathComponent("Checklist.plist")
  }
  
  func itemDetailViewControllerDidCancel(controller: ItemDetailViewController) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  func itemDetailViewController(controller: ItemDetailViewController,
                             didFinishAddingItem item: ChecklistItem) {
    
    let newRowIndex = items.count
    items.append(item)
    let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
    let indexPaths = [indexPath]
    tableView.insertRowsAtIndexPaths(indexPaths,
                                     withRowAnimation: .Automatic)
    dismissViewControllerAnimated(true, completion: nil)
    saveChecklistItems()
  }
  
  func itemDetailViewController(controller: ItemDetailViewController,
                             didFinishEditingItem item: ChecklistItem) {
    if let index = items.indexOf(item) {
      let indexPath = NSIndexPath(forRow: index, inSection: 0)
      if let cell = tableView.cellForRowAtIndexPath(indexPath) {
        configureTextForCell(cell, withChecklistItem: item)
      }
    }
    dismissViewControllerAnimated(true, completion: nil)
    saveChecklistItems()
  }
 
  var items: [ChecklistItem]
  
  required init?(coder aDecoder: NSCoder) {
    items = [ChecklistItem]()
    
    super.init(coder: aDecoder)
    loadChecklistItems()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
 

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    return items.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
    
    let cell = tableView.dequeueReusableCellWithIdentifier("CheckListItem", forIndexPath: indexPath)
    let item = items[indexPath.row]
    
    configureTextForCell(cell, withChecklistItem: item)
    configureCheckmarkForCell(cell, withChecklistItem: item)
    return cell
    
  }
  
  override func tableView(tableView: UITableView,
                          didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if let cell = tableView.cellForRowAtIndexPath(indexPath) {
      let item = items[indexPath.row]
      item.toggleChecked()
      configureCheckmarkForCell(cell, withChecklistItem: item)
    }
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    saveChecklistItems()
  }
  
  override func tableView(tableView: UITableView,
                          commitEditingStyle editingStyle: UITableViewCellEditingStyle,
                                             forRowAtIndexPath indexPath: NSIndexPath) {
    // 1
    items.removeAtIndex(indexPath.row)
    // 2
    let indexPaths = [indexPath]
    tableView.deleteRowsAtIndexPaths(indexPaths,
                                     withRowAnimation: .Automatic)
    saveChecklistItems()
  }
  
  func configureCheckmarkForCell(cell: UITableViewCell,
                                 withChecklistItem item: ChecklistItem) {
    let label = cell.viewWithTag(1001) as! UILabel
    if item.checked {
      label.text = "✔︎"
    } else {
      label.text = "✘"
    }
  }
  
  func configureTextForCell(cell: UITableViewCell,
                            withChecklistItem item: ChecklistItem) {
    let label = cell.viewWithTag(1000) as! UILabel
    label.text = item.text
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue,
                                sender: AnyObject?) {
    // 1
    if segue.identifier == "AddItem" {
      // 2
      let navigationController = segue.destinationViewController
        as! UINavigationController
      // 3
      let controller = navigationController.topViewController
        as! ItemDetailViewController
      // 4
      controller.delegate = self
    }
    
    else if segue.identifier == "EditItem"{
      
      let navigationController = segue.destinationViewController
        as! UINavigationController
      let controller = navigationController.topViewController
        as! ItemDetailViewController
      controller.delegate = self
      if let indexPath = tableView.indexPathForCell(
        sender as! UITableViewCell) {
        controller.itemToEdit = items[indexPath.row]
      }
    }
  }
  
  
}
