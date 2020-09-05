//
//  ToDoListViewController.swift
//  ToDoApp
//
//  Created by Ryniere dos Santos Silva on 2020-09-05.
//  Copyright © 2020 Ryniere dos Santos Silva. All rights reserved.
//

import UIKit
import RxSwift

class ToDoListViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!

    let searchController = UISearchController(searchResultsController: nil)
    
    
    var viewModel: TaskListViewModel!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupBinding()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Filter"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = ToDoFilterEnum.allCases.map { $0.rawValue }
        searchController.searchBar.delegate = self
        
    }
    
    func setupBinding() {
        
        viewModel = TaskListViewModel(taskService: TaskService.shared)
        
        viewModel.tasks
            .drive(onNext: {[unowned self] (_) in
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ToDoListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfTasks
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell
        if let viewModel = viewModel.viewModelForTask(at: indexPath.row) {
            cell.configure(viewModel: viewModel)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}


extension ToDoListViewController: UISearchResultsUpdating {
    
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    
    guard let text = searchBar.text  else {
        return
    }
   
  }
}

extension ToDoListViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
   
  }
}
