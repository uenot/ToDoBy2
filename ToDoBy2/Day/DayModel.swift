//
//  DayModel.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 1/15/23.
//

import Foundation

struct DayModel: Identifiable, Codable, Equatable {
    typealias ID = Date
    var id: ID { date }
    private(set) var date: Date
    private(set) var taskLists: [TaskListModel] = [TaskListModel(tasks: [], type: .normal),
                                                   TaskListModel(tasks: [], type: .optional)]
    var baseList: TaskListModel { taskLists.first { $0.type == .normal }! }
    var complete: Bool {
        baseList.tasks.count > 0 && baseList.tasks.allSatisfy { $0.isComplete }
    }
}

extension DayModel {
    enum Action {
        case editList(TaskListModel.ID, TaskListModel.Action)
        case moveTask(TaskModel.ID, TaskListModel.ID, TaskListModel.ID)
    }
    
    static func reducer(model: inout Self, action: Self.Action) -> Void {
        switch action {
        case let .editList(id, subAction):
            let i = model.taskLists.firstIndex(where: { $0.id == id })!
            TaskListModel.reducer(model: &model.taskLists[i], action: subAction)
        case let .moveTask(taskId, sourceId, destId):
            let task = model.taskLists.first { $0.id == sourceId }!
                .tasks.first { $0.id == taskId }!
            reducer(model: &model, action: .editList(sourceId, .removeTask(taskId)))
            reducer(model: &model, action: .editList(destId, .addTask(task)))
        }
    }
}

extension DayModel {
    static let samples = [
        DayModel(date: Date(), taskLists: TaskListModel.samples)
    ]
}
