//
//  ItemDetailViewController.swift
//  CheckList
//
//  Created by Amrish Mahesh on 2/08/2016.
//  Copyright © 2016 Amrish Mahesh. All rights reserved.
//

import Foundation
import UIKit

protocol ItemDetailViewControllerDelegate: class {
  func itemDetailViewControllerDidCancel(controller: ItemDetailViewController)
  func itemDetailViewController(controller: ItemDetailViewController,
                             didFinishAddingItem item: ChecklistItem)
  func itemDetailViewController(controller: ItemDetailViewController,
                             didFinishEditingItem item: ChecklistItem)
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate{

  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var doneBarButton: UIBarButtonItem!
  
  weak var delegate: ItemDetailViewControllerDelegate?
  
  var itemToEdit: ChecklistItem?
  
  @IBAction func cancel() {
    delegate?.itemDetailViewControllerDidCancel(self)
  }
  @IBAction func done() {
    if let item = itemToEdit {
      item.text = textField.text!
      delegate?.itemDetailViewController(self, didFinishEditingItem: item)
    } else {
      let item = ChecklistItem()
      item.text = textField.text!
      item.checked = false
      delegate?.itemDetailViewController(self, didFinishAddingItem: item)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let item = itemToEdit {
      title = "Edit Item"
      textField.text = item.text
      doneBarButton.enabled = true
    }
  }
  
  override func tableView(tableView: UITableView,
                          willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    return nil
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    textField.becomeFirstResponder()
  }
  
  func textField(textField: UITextField,
                 shouldChangeCharactersInRange range: NSRange,
                                               replacementString string: String) -> Bool {
    let oldText: NSString = textField.text!
    let newText: NSString = oldText.stringByReplacingCharactersInRange(
      range, withString: string)
    if newText.length > 0 {
      doneBarButton.enabled = true
    } else {
      doneBarButton.enabled = false
    }
    return true
  }
  
}