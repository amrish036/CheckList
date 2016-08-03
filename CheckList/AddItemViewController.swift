//
//  AddItemViewController.swift
//  CheckList
//
//  Created by Amrish Mahesh on 2/08/2016.
//  Copyright © 2016 Amrish Mahesh. All rights reserved.
//

import Foundation
import UIKit

protocol AddItemViewControllerDelegate: class {
  func addItemViewControllerDidCancel(controller: AddItemViewController)
  func addItemViewController(controller: AddItemViewController,
                             didFinishAddingItem item: ChecklistItem)
  func addItemViewController(controller: AddItemViewController,
                             didFinishEditingItem item: ChecklistItem)
}

class AddItemViewController: UITableViewController, UITextFieldDelegate{

  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var doneBarButton: UIBarButtonItem!
  
  weak var delegate: AddItemViewControllerDelegate?
  
  var itemToEdit: ChecklistItem?
  
  @IBAction func cancel() {
    delegate?.addItemViewControllerDidCancel(self)
  }
  @IBAction func done() {
    if let item = itemToEdit {
      item.text = textField.text!
      delegate?.addItemViewController(self, didFinishEditingItem: item)
    } else {
      let item = ChecklistItem()
      item.text = textField.text!
      item.checked = false
      delegate?.addItemViewController(self, didFinishAddingItem: item)
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