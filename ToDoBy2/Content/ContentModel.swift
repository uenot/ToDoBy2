//
//  ContentModel.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 4/24/23.
//

import Foundation

struct ContentModel: Codable {
    private(set) var taskManager: TaskManagerModel
}

extension ContentModel {
    enum Action {
        case editTaskManager(TaskManagerModel.Action)
        case load(ContentModel)
    }
    
    static func reducer(model: inout Self, action: Action) -> Void {
        switch action {
        case let .editTaskManager(subAction):
            TaskManagerModel.reducer(model: &model.taskManager, action: subAction)
        case let .load(newModel):
            model = newModel
        }
    }
}

extension ContentModel {
    static let sample = ContentModel(taskManager: TaskManagerModel.sample)
}
