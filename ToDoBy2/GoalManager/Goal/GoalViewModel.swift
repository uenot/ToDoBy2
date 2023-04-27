//
//  GoalViewModel.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 4/26/23.
//

import Foundation

typealias GoalViewModel = ViewModel<GoalModel, GoalModel.Action>

extension GoalViewModel {
    var title: String { model.title }
    var desc: String { model.desc }
    var deadline: Date? { model.deadline }
    var priority: GoalModel.Priority { model.priority }
    var isComplete: Bool { model.isComplete }
    var completedDate: Date? { model.completedDate }
}

extension GoalViewModel {
    static let sample = GoalViewModel(model: GoalModel.samples[0], reducer: GoalModel.reducer)
}
