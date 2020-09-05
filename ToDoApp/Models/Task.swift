//
//  ToDo.swift
//  ToDoApp
//
//  Created by Ryniere dos Santos Silva on 2020-09-05.
//  Copyright © 2020 Ryniere dos Santos Silva. All rights reserved.
//

import Foundation


struct Task: Codable {
    
    let id, userId: Int
    let title: String
    let completed: Bool
}
