//
//  TaskListViewModel.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 3/14/23.
//

import Foundation

typealias TaskListViewModel = ViewModel<TaskListModel, TaskListModel.Action>

extension TaskListViewModel {
    func createTaskViewModel(id: TaskModel.ID) -> TaskViewModel {
        let convertModel: (TaskListModel) -> TaskModel = { model in model.tasks.first(where: { $0.id == id })! }
        let convertAction: (TaskModel.Action) -> TaskListModel.Action = { action in
            switch action {
            case .deleteSelf:
                return .removeTask(id)
            default:
                return .editTask(id, action)
            }
        }
        return createSubViewModel(convertModel, convertAction)
    }
    
    var tasks: [TaskModel] { model.tasks }
    var type: TaskListModel.ListType { model.type }
}

extension TaskListViewModel {
    static var sample = TaskListViewModel(model: .init(tasks: TaskModel.samples, type: .normal), reducer: TaskListModel.reducer)
}
