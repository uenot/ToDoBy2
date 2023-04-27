//
//  GoalModel.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 4/25/23.
//

import Foundation

struct GoalModel: Identifiable, Codable {
    typealias ID = UUID
    var id = UUID()
    var title: String
    var desc: String
    var deadline: Date?
    var priority: Priority
    
    var isComplete = false
    var completedDate: Date?
    // substeps? days worked on (history)?
}

extension GoalModel {
    enum Priority: Comparable, Codable, CustomStringConvertible {
        case low
        case medLow
        case med
        case medHigh
        case high
        
        var description: String {
            switch self {
            case .low:
                return "Low"
            case .medLow:
                return "Medium-Low"
            case .med:
                return "Medium"
            case .medHigh:
                return "Medium-High"
            case .high:
                return "High"
            }
        }
    }
}

extension GoalModel {
    enum Action {
        case editTitle(String)
        case editDesc(String)
        case setDeadline(Date?)
        case setPriority(Priority)
        case markComplete
        case markIncomplete
    }
    
    static func reducer(model: inout Self, action: GoalModel.Action) -> Void {
        switch action {
        case let .editTitle(newTitle):
            model.title = newTitle
        case let .editDesc(newDesc):
            model.desc = newDesc
        case let .setDeadline(newDeadline):
            model.deadline = newDeadline
        case let .setPriority(newPriority):
            model.priority = newPriority
        case .markComplete:
            model.isComplete = true
            model.completedDate = Date()
        case .markIncomplete:
            model.isComplete = false
            model.completedDate = nil
        }
    }
}

extension GoalModel {
    static let samples = [
        GoalModel(title: "Goal 1", desc: "test desc", priority: .medHigh),
        GoalModel(title: "Goal 2", desc: "test desc again", deadline: Date(), priority: .high),
        GoalModel(title: "Goal 3", desc: "test desc three", priority: .medLow),
        GoalModel(title: "Goal 4", desc: "test desc for a fourth time", priority: .low),
        GoalModel(title: "Goal 5", desc: "test desc for a fifth time",
                  deadline: Calendar.current.date(byAdding: .day, value: 2, to: Date()), priority: .med),
    ]
}
