//
//  GoalManagerModel.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 4/25/23.
//

import Foundation

struct GoalManagerModel: Codable {
    var goals: [GoalModel]
}

extension GoalManagerModel {
    enum Action {
        case addGoal(GoalModel)
        case editGoal(GoalModel.ID, GoalModel.Action)
        case deleteGoal(GoalModel.ID)
    }
    
    static func reducer(model: inout Self, action: GoalManagerModel.Action) -> Void {
        switch action {
        case let .addGoal(newGoal):
            model.goals.append(newGoal)
        case let .deleteGoal(id):
            model.goals.removeAll { $0.id == id }
        case let .editGoal(id, subAction):
            let i = model.goals.firstIndex { $0.id == id }!
            GoalModel.reducer(model: &model.goals[i], action: subAction)
        }
    }
}

extension GoalManagerModel {
    static let sample = GoalManagerModel(goals: GoalModel.samples)
}
