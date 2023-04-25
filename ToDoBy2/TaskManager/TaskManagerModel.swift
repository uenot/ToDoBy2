//
//  TaskManagerModel.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 1/15/23.
//

import Foundation

struct TaskManagerModel: Codable {
    private(set) var days: [DayModel]
    private(set) var currentDay: DayModel
    
    init(days: [DayModel], currentDay: DayModel) {
        self.days = days
        self.currentDay = currentDay
    }
    
    init(days: [DayModel], date: Date = Date()) {
        self.days = days
        currentDay = days.first { $0.date == date } ?? DayModel(date: date)
    }
}

extension TaskManagerModel {
    
    enum Action {
        case addDay(DayModel)
        case removeDay(DayModel.ID)
        case editDay(DayModel.ID, DayModel.Action)
        case setDate(Date)
    }
    
    func getDay(for date: Date) -> DayModel {
        days.first {$0.date == date}
        ?? (currentDay.date == date ? currentDay : nil)
        ?? DayModel(date: date)
    }
    
    static func reducer(model: inout Self, action: Action) -> Void {
        switch action {
        case let .addDay(newDay):
            model.days.append(newDay)
        case let .removeDay(id):
            model.days.removeAll(where: { $0.id == id })
        case let .editDay(id, subAction):
            if let i = model.days.firstIndex(where: { $0.id == id }) {
                DayModel.reducer(model: &model.days[i], action: subAction)
            } else {
                reducer(model: &model, action: .addDay(model.currentDay))
                reducer(model: &model, action: .editDay(id, subAction))
            }
        case let .setDate(newDate):
            model.currentDay = model.getDay(for: newDate)
        }
    }
}

extension TaskManagerModel {
    static var sample = TaskManagerModel(days: DayModel.samples)
}
