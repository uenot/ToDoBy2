//
//  TaskManagerViewModel.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 1/15/23.
//

import SwiftUI

typealias TaskManagerViewModel = ViewModel<TaskManagerModel, TaskManagerModel.Action>

extension TaskManagerViewModel {
    func createDayViewModel(day: DayModel) -> DayViewModel {
        let convertModel: (TaskManagerModel) -> DayModel = { model in
            model.days.first { $0.id == day.id }
            ?? (model.currentDay.id == day.id ? model.currentDay : nil)
            ?? DayModel(date: day.date, tasks: [])
        }
        let convertAction: (DayModel.Action) -> TaskManagerModel.Action = { action in
                .editDay(day.id, action)
        }
        return createSubViewModel(convertModel, convertAction)
    }
    
    var days: [DayModel] { model.days }
    var currentDay: DayModel { model.currentDay }
    var currentDate: Date { currentDay.date }
    func getDay(for date: Date) -> DayModel {
        model.getDay(for: date)
    }
    
    private func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("taskmanager.json")
    }
    
    func load() async -> Void {
        let newModel = await Task(priority: .background) {
            do {
                let url = try fileURL()
                let file = try FileHandle(forReadingFrom: url)
                let result = try JSONDecoder().decode(TaskManagerModel.self, from: file.availableData)
                return result
            } catch {
                print(error.localizedDescription)
                return TaskManagerModel(days: [])
            }
        }.value
        self.send(.load(newModel))
    }
    
    func save() async -> Void {
        Task(priority: .background) {
            do {
                let data = try JSONEncoder().encode(model)
                let url = try fileURL()
                try data.write(to: url)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension TaskManagerViewModel {
    static var sample = TaskManagerViewModel(model: .init(days: DayModel.samples), reducer: TaskManagerModel.reducer)
}
