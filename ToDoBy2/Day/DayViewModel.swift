//
//  DayViewModel.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 1/15/23.
//

import SwiftUI

typealias DayViewModel = ViewModel<DayModel, DayModel.Action>

extension DayViewModel {
    func createTaskViewModel(id: TaskModel.ID) -> TaskViewModel {
        let convertModel: (DayModel) -> TaskModel = { model in model.tasks.first(where: { $0.id == id })! }
        let convertAction: (TaskModel.Action) -> DayModel.Action = { action in
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
    var date: Date { model.date }
    
    var header: String {
        "Tasks for " + model.date.formatted(date: .abbreviated, time: .omitted)
    }
}

extension DayViewModel {
    static var sample = DayViewModel(model: .init(date: Date(), tasks: TaskModel.samples), reducer: DayModel.reducer)
}
