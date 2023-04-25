//
//  DayViewModel.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 1/15/23.
//

import SwiftUI

typealias DayViewModel = ViewModel<DayModel, DayModel.Action>

extension DayViewModel {
    func createTaskListViewModel(id: TaskListModel.ID) -> TaskListViewModel {
        let convertModel: (DayModel) -> TaskListModel = { model in model.taskLists.first(where: { $0.id == id })! }
        let convertAction: (TaskListModel.Action) -> DayModel.Action = { action in
            switch action {
            case let .moveTask(taskId):
                let destId = self.taskLists.first { $0.id != id }!.id // only works for two lists
                return .moveTask(taskId, id, destId)
            default:
                return .editList(id, action)
            }
        }
        return createSubViewModel(convertModel, convertAction)
    }
    
    var taskLists: [TaskListModel] { model.taskLists }
    var baseList: TaskListModel { model.baseList }
    var complete: Bool { model.complete }
    var date: Date { model.id }
    
    var header: String {
        "Tasks for " + model.id.formatted(date: .abbreviated, time: .omitted)
    }
}

extension DayViewModel {
    static var sample = DayViewModel(model: DayModel.samples[0], reducer: DayModel.reducer)
}
