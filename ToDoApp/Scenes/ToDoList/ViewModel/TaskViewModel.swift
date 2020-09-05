//
//  ToDoViewModel.swift
//  ToDoApp
//
//  Created by Ryniere dos Santos Silva on 2020-09-05.
//  Copyright © 2020 Ryniere dos Santos Silva. All rights reserved.
//

import Foundation

struct TaskViewModel {
    
    private var task: Task
    
    init(task: Task) {
        self.task = task
    }
    
    var title: String {
        return task.title
    }
    
    var completed: Bool {
        return task.completed
    }
    
}
