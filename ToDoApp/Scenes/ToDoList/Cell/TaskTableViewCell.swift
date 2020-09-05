//
//  ToDoTableViewCell.swift
//  ToDoApp
//
//  Created by Ryniere dos Santos Silva on 2020-09-05.
//  Copyright © 2020 Ryniere dos Santos Silva. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    var viewModel: TaskViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        guard let _viewModel = viewModel else { return }
        titleLabel.text = selected ? _viewModel.title : _viewModel.title.trunc(length: 20)
    }
    
    override func didMoveToSuperview() {
        selectionStyle = .none
    }
    
    func configure(viewModel: TaskViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title.trunc(length: 20)
        self.accessoryType = viewModel.completed ? .checkmark : .none
    }

}
