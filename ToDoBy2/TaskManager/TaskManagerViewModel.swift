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
            ?? DayModel(date: day.date)
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
    
    // this is fucking grosssssss
    // every call to allX iterateas through all possible X
    // action-capturing should be done in each respective component
    // solution: refactor those functions to each component
    // may need to take in IDs of parents, which is fine?
    // at the beginning of this func: perform one search for appropro day/tasklist ID
    // use those to get convertModel/convertAction in constant time afterwards
    
    // ideally abstract knowledge of deeper children from parent
    // but highest priority is abstracting parents from children
    
    // it seems like we have to get the IDs of parents of TaskModel here anyways
    // alternative: call cascading createSubViewModels from day to tasklist to task
    
    func createTaskViewModel(id: TaskModel.ID) -> TaskViewModel {
        
        let dayID = days.first { $0.taskLists.contains { $0.tasks.contains { $0.id == id } } }!
        let listID = days.flatMap { $0.taskLists }.first { $0.tasks.contains { $0.id == id } }!.id
        
        return createDayViewModel(day: dayID)
            .createTaskListViewModel(id: listID)
            .createTaskViewModel(id: id)
    }
}

extension TaskManagerViewModel {
    static var sample = TaskManagerViewModel(model: TaskManagerModel.sample, reducer: TaskManagerModel.reducer)
}
