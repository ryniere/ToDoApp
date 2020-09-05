//
//  StringExtension.swift
//  ToDoApp
//
//  Created by Ryniere dos Santos Silva on 2020-09-05.
//  Copyright © 2020 Ryniere dos Santos Silva. All rights reserved.
//

import Foundation

extension String {
  
  func trunc(length: Int, trailing: String = "…") -> String {
    return (self.count > length) ? self.prefix(length) + trailing : self
  }
}
