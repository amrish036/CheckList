//
//  AddItemViewController.swift
//  CheckList
//
//  Created by Amrish Mahesh on 2/08/2016.
//  Copyright © 2016 Amrish Mahesh. All rights reserved.
//

import Foundation
import UIKit

class AddItemViewController: UITableViewController, UITextFieldDelegate{

  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var doneBarButton: UIBarButtonItem!
  
  @IBAction func cancel() {
    dismissViewControllerAnimated(true, completion: nil)
  }
  @IBAction func done() {
    print(textField.text!)
    dismissViewControllerAnimated(true, completion: nil)
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