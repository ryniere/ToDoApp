//
//  ToDoFilterEnum.swift
//  ToDoApp
//
//  Created by Ryniere dos Santos Silva on 2020-09-05.
//  Copyright © 2020 Ryniere dos Santos Silva. All rights reserved.
//

import Foundation

typealias RawValue = String

enum TaskFilterEnum: CaseIterable {
  case all
  case complete
  case incomplete
    
    init?(rawValue: RawValue) {
      switch rawValue {
      case "All": self = .all
      case "Complete": self = .complete
      case "Incomplete": self = .incomplete
      default: return nil
      }
    }
    
    var rawValue: RawValue {
      switch self {
      case .all: return "All"
      case .complete: return "Complete"
      case .incomplete: return "Incomplete"
      }
    }
}
