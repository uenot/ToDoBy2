//
//  GoalManagerViewModel.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 4/25/23.
//

import Foundation

typealias GoalManagerViewModel = ViewModel<GoalManagerModel, GoalManagerModel.Action>

extension GoalManagerViewModel {
    func createGoalViewModel(id: GoalModel.ID) -> GoalViewModel {
        let deriveModel: (GoalManagerModel) -> GoalModel = { model in
            model.goals.first { $0.id == id }!
        }
        let translateAction: (GoalModel.Action) -> GoalManagerModel.Action = { action in
                .editGoal(id, action)
        }
        return createSubViewModel(deriveModel, translateAction)
    }
    
    var goals: [GoalModel] { model.goals }
}

extension GoalManagerViewModel {
    static let sample = GoalManagerViewModel(model: GoalManagerModel.sample, reducer: GoalManagerModel.reducer)
}
