//
//  ToDoListViewModel.swift
//  ToDoApp
//
//  Created by Ryniere dos Santos Silva on 2020-09-05.
//  Copyright © 2020 Ryniere dos Santos Silva. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa



class TaskListViewModel {
    
    private let taskService: TaskService
    private let disposeBag = DisposeBag()
    
    init(taskService: TaskService) {
        self.taskService = taskService
        
        self.fetchTasks()
    }
    
    private let _tasks = BehaviorRelay<[Task]>(value: [])
    private let _tasksFiltered = BehaviorRelay<[Task]>(value: [])
    private let _isFetching = BehaviorRelay<Bool>(value: false)
    private let _error = BehaviorRelay<String?>(value: nil)
    
    
    var isFetching: Driver<Bool> {
        return _isFetching.asDriver()
    }
    
    var tasks: Driver<[Task]> {
        return _tasks.asDriver()
    }
    
    var tasksFiltered: Driver<[Task]> {
        return _tasksFiltered.asDriver()
    }
    
    var error: Driver<String?> {
        return _error.asDriver()
    }
    
    var hasError: Bool {
        return _error.value != nil
    }
    
    var numberOfTasks: Int {
        return _tasks.value.count
    }
    
    var numberOfFilteredTasks: Int {
        return _tasksFiltered.value.count
    }
    
    func viewModelForTask(at index: Int, isFiltering:Bool) -> TaskViewModel? {
        guard index < _tasks.value.count else {
            return nil
        }
        return isFiltering ? TaskViewModel(task: _tasksFiltered.value[index]) : TaskViewModel(task: _tasks.value[index])
    }
    
    
    private func fetchTasks() {
        self._tasks.accept([])
        self._isFetching.accept(true)
        self._error.accept(nil)
        
        taskService.fetchTasks(successHandler: {[weak self] (tasks) in
            self?._isFetching.accept(false)
            self?._tasks.accept(tasks)
    
            
        }) { [weak self] (error) in
            self?._isFetching.accept(false)
            self?._error.accept(error.localizedDescription)
        }
    }
    
    func filterTasks(query:String, taskFilter:TaskFilterEnum = .all) {
        
        let tasksTemp = _tasks.value.filter { task -> Bool in
            
            switch taskFilter {
            case .all:
                 return task.title.lowercased().contains(query.lowercased())
            case .complete:
                return task.title.lowercased().contains(query.lowercased()) && task.completed
            case .incomplete:
                return task.title.lowercased().contains(query.lowercased()) && !task.completed
            }
            
        }
        
        _tasksFiltered.accept(tasksTemp)
        
    }
    
}
