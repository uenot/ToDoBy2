//
//  TaskListView.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 3/14/23.
//

import SwiftUI

struct TaskListView: View {
    
    @ObservedObject var vm: TaskListViewModel
    
    var title: String {
        switch vm.type {
        case .normal:
            return "Normal"
        case .optional:
            return "Optional"
        }
    }
    
    var body: some View {
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
                        Button("Move to \(vm.otherType.description)") {
                            vm.send(.moveTask(task.id))
                        }
                        .tint(Color.yellow)
                    }
            }
        }
        .onMove { source, destination in
            vm.send(.reorderTasks(source, destination))
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            TaskListView(vm: TaskListViewModel.samples[0])
        }
    }
}
