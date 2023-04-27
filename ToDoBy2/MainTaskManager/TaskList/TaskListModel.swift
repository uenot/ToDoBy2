//
//  TaskListModel.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 3/14/23.
//

import Foundation

struct TaskListModel: Identifiable, Codable, Equatable {
    typealias ID = UUID
    private(set) var id = UUID()
    private(set) var tasks: [TaskModel]
    let type: ListType
    var otherType: ListType {
        switch type {
        case .normal:
            return .optional
        case .optional:
            return .normal
        }
    }
    
    enum ListType: Codable, CustomStringConvertible {
        case normal
        case optional
        
        var description: String {
            switch self {
            case .normal:
                return "Normal"
            case .optional:
                return "Optional"
            }
        }
    }
}

extension TaskListModel {
    enum Action {
        case addTask(TaskModel)
        case removeTask(TaskModel.ID)
        case editTask(TaskModel.ID, TaskModel.Action)
        case reorderTasks(IndexSet, Int)
        case moveTask(TaskModel.ID)
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
        case .moveTask:
            break // handled in DayView
        }
    }
}

extension TaskListModel {
    static var samples = [
        TaskListModel(tasks: Array(TaskModel.samples[0..<4]), type: .normal),
        TaskListModel(tasks: Array(TaskModel.samples[4..<8]), type: .optional)
    ]
}
