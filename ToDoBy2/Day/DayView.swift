//
//  DayView.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 1/15/23.
//

import SwiftUI

struct DayView: View {
    
    @ObservedObject var vm: DayViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.tasks) { task in
                    NavigationLink(value: task.id) {
                        Text(task.title)
                            .foregroundColor(task.isComplete ? .green : nil)
                            .strikethrough(task.isComplete)
                            .swipeActions(edge: .leading) {
                                if (task.isComplete) {
                                    Button("Incomplete") {
                                        vm.send(.editTask(task.id, .markIncomplete))
                                    }
                                    .tint(.indigo)
                                } else {
                                    Button("Complete") {
                                        vm.send(.editTask(task.id, .markComplete))
                                    }
                                    .tint(.green)
                                }
                            }
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    vm.send(.removeTask(task.id))
                                } label: {
                                    Text("Delete")
                                }
                            }
                    }
                }
            }
            .navigationTitle(vm.header)
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: TaskModel.ID.self) { id in
                TaskView(vm: vm.createTaskViewModel(id: id))
            }
            Button("Add Task") {
                vm.send(.addTask(TaskModel(title: "New Task")))
            }
        }
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(vm: DayViewModel.sample)
    }
}
