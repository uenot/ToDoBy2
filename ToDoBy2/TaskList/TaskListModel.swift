//
//  TaskListModel.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 3/14/23.
//

import Foundation

struct TaskListModel: Codable, Equatable {
    private(set) var tasks: [TaskModel]
    let type: ListType
    
    enum ListType: Codable {
        case normal
        case optional
    }
}

extension TaskListModel {
    enum Action {
        case addTask(TaskModel)
        case removeTask(TaskModel.ID)
        case editTask(TaskModel.ID, TaskModel.Action)
        case reorderTasks(IndexSet, Int)
    }
    
    static func reducer(model: inout Self, action: Self.Action) -> Void {
        switch action {
        case let .addTask(newTask):
            model.tasks.append(newTask)
        case let .removeTask(id):
            model.tasks.removeAll(where: { $0.id == id })
        case let .editTask(id, subAction):
            let i = model.tasks.firstIndex(where: { $0.id == id })!
            TaskModel.reducer(model: &model.tasks[i], action: subAction)
        case let .reorderTasks(source, destination):
            model.tasks.move(fromOffsets: source, toOffset: destination)
        }
    }
}
