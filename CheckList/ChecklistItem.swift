//
//  ChecklistItem.swift
//  CheckList
//
//  Created by Amrish Mahesh on 2/08/2016.
//  Copyright © 2016 Amrish Mahesh. All rights reserved.
//

import Foundation



class ChecklistItem: NSObject, NSCoding {
  var text = ""
  var checked = false
  
  func toggleChecked() {
    checked = !checked
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(text, forKey: "Text")
    aCoder.encodeBool(checked, forKey: "Checked")
  }
  
  required init?(coder aDecoder: NSCoder) {
  
    text = aDecoder.decodeObjectForKey("Text") as! String
    checked = aDecoder.decodeBoolForKey("Checked")
    super.init()
  }
  
  override init() {
    super.init()
  }
  
  
}
