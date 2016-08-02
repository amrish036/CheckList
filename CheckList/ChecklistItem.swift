//
//  ChecklistItem.swift
//  CheckList
//
//  Created by Amrish Mahesh on 2/08/2016.
//  Copyright © 2016 Amrish Mahesh. All rights reserved.
//

import Foundation

class ChecklistItem {
  var text = ""
  var checked = false
  
  func toggleChecked() {
    checked = !checked
  }
}
