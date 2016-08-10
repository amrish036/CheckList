//
//  Checklist.swift
//  CheckList
//
//  Created by Amrish Mahesh on 8/08/2016.
//  Copyright © 2016 Amrish Mahesh. All rights reserved.
//

import UIKit

class Checklist: NSObject, NSCoding {
  
   var name = ""
  var items: [ChecklistItem] = [ChecklistItem]()

  init(name: String){
    self.name = name
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObjectForKey("Name") as! String
    items = aDecoder.decodeObjectForKey("Items") as! [ChecklistItem]
    super.init()
  }
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(name, forKey: "Name")
    aCoder.encodeObject(items, forKey: "Items")
  }
  
  func countUncheckedItems() -> Int {
    var count = 0
    for item in items where !item.checked {
      count += 1
    }
    return count
  }
  
}
