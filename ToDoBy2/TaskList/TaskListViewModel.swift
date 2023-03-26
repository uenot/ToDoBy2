//
//  TaskListViewModel.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 3/14/23.
//

import Foundation

typealias TaskListViewModel = ViewModel<TaskListModel, TaskListModel.Action>

extension TaskListViewModel {
    var tasks: [TaskModel] { model.tasks }
    var type: TaskListModel.ListType { model.type }
    var otherType: TaskListModel.ListType { model.otherType }
}

extension TaskListViewModel {
    static var samples = [
        TaskListViewModel(model: TaskListModel.samples[0], reducer: TaskListModel.reducer),
        TaskListViewModel(model: TaskListModel.samples[1], reducer: TaskListModel.reducer)
    ]
}
