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
                    NavigationLink(task.title, value: task.id)
                }
            }
            .navigationTitle(vm.header)
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: TaskModel.ID.self) { id in
                TaskView(vm: vm.createTaskViewModel(id: id))
            }
            Button("Add Dummy Task") {
                vm.send(.addTask(TaskModel(title: "new task!!!!!")))
            }
        }
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(vm: DayViewModel.sample)
    }
}
