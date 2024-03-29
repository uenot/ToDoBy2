//
//  TaskViewModel.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 1/16/23.
//

import SwiftUI

typealias TaskViewModel = ViewModel<TaskModel, TaskModel.Action>

extension TaskViewModel {
    var title: String { model.title }
    var isComplete: Bool { model.isComplete }
}

extension TaskViewModel {
    static var sample = TaskViewModel(model: TaskModel.samples[0], reducer: TaskModel.reducer)
}
