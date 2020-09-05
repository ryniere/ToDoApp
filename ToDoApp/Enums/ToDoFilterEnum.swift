//
//  ToDoFilterEnum.swift
//  ToDoApp
//
//  Created by Ryniere dos Santos Silva on 2020-09-05.
//  Copyright © 2020 Ryniere dos Santos Silva. All rights reserved.
//

import Foundation

typealias RawValue = String

enum ToDoFilterEnum: CaseIterable {
  case all
  case complete
  case incomplete
    
    var rawValue: RawValue {
      switch self {
      case .all: return "All"
      case .complete: return "Complete"
      case .incomplete: return "Incomplete"
      }
    }
}
