//
//  TaskModel.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 1/15/23.
//

import Foundation

struct TaskModel: Identifiable, Codable {
    typealias ID = UUID
    private(set) var id = UUID()
    private(set) var title: String
}

extension TaskModel {
    
    enum Action {
        case editTitle(String)
    }
    
    static func reducer(model: inout Self, action: TaskModel.Action) -> Void {
        switch action {
        case let .editTitle(newTitle):
            model.title = newTitle
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
