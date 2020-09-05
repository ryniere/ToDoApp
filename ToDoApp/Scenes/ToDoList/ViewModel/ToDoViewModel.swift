//
//  ToDoViewModel.swift
//  ToDoApp
//
//  Created by Ryniere dos Santos Silva on 2020-09-05.
//  Copyright © 2020 Ryniere dos Santos Silva. All rights reserved.
//

import Foundation

struct TaskViewModel {
    
    private var toDo: Task
    
    init(toDo: Task) {
        self.toDo = toDo
    }
    
    var title: String {
        return toDo.title
    }
    
    var completed: Bool {
        return toDo.completed
    }
    
}
