//
//  TaskModel.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 1/15/23.
//

import Foundation

struct TaskModel: Identifiable, Codable, Equatable {
    typealias ID = UUID
    private(set) var id = UUID()
    private(set) var title: String
    private(set) var isComplete = false
}

extension TaskModel {
    
    enum Action {
        case editTitle(String)
        case markComplete
        case markIncomplete
        case deleteSelf
    }
    
    static func reducer(model: inout Self, action: TaskModel.Action) -> Void {
        switch action {
        case let .editTitle(newTitle):
            model.title = newTitle
        case .markComplete:
            model.isComplete = true
        case .markIncomplete:
            model.isComplete = false
        case .deleteSelf:
            break  // handled in TaskListModel
        }
    }
}

extension TaskModel {
    static var samples = [
        TaskModel(title: "Task 1"),
        TaskModel(title: "Task 2"),
        TaskModel(title: "Task 3"),
        TaskModel(title: "Task 4"),
        TaskModel(title: "Task 5"),
        TaskModel(title: "Task 6"),
        TaskModel(title: "Task 7"),
        TaskModel(title: "Task 8"),
    ]
}
