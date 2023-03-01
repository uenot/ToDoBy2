//
//  DayModel.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 1/15/23.
//

import Foundation

struct DayModel: Identifiable, Codable, Equatable {
    typealias ID = UUID
    private(set) var id = UUID()
    let date: Date
    private(set) var tasks: [TaskModel]
}

extension DayModel {
    
    enum Action {
        case addTask(TaskModel)
        case removeTask(TaskModel.ID)
        case editTask(TaskModel.ID, TaskModel.Action)
        case reorderTasks(IndexSet, Int)
        case changeDay(Date)
    }
    
    static func reducer(model: inout Self, action: DayModel.Action) -> Void {
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
        case .changeDay:
            break
        }
    }
}

extension DayModel {
    static let samples = [
        DayModel(date: Date(), tasks: Array(TaskModel.samples[0..<4])),
        DayModel(date: Date()+1, tasks: Array(TaskModel.samples[4..<8]))
    ]
}
