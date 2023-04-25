//
//  DayView.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 1/15/23.
//

import SwiftUI

struct DayView: View {
    
    @ObservedObject var vm: DayViewModel
    
    @Binding var displayDatePicker: Bool
    @Environment(\.editMode) var editMode
    
    let jumpToDate: (Date) -> Void
    var selectedDate: Binding<Date> {
        Binding {
            vm.date
        } set: { newValue in
            withAnimation {
                displayDatePicker.toggle()
            }
            jumpToDate(newValue)
        }
    }
    
    var body: some View {
        VStack {
            Text(vm.header)
                .font(.system(.largeTitle, design: .rounded).weight(.bold))
                .opacity(vm.complete ? 0.75 : 1)
                .strikethrough(vm.complete)
                .foregroundColor(vm.complete ? .green : nil)
                .animation(.easeOut(duration: 0.2), value: vm.complete)
            if (displayDatePicker) {
                DatePicker("",
                           selection: selectedDate,
                           displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .padding()
            }
            List {
                ForEach(vm.taskLists) { taskList in
                    if (taskList.tasks.count > 0) {
                        Section {
                            TaskListView(vm: vm.createTaskListViewModel(id: taskList.id))
                        } header: {
                            Text(taskList.type.description)
                        }
                    }
                }
            }
            Button("Add Task") {
                vm.send(.editList(vm.baseList.id, .addTask(TaskModel(title: "New Task"))))
            }
            .padding()
            Button("Jump to Today") {
                jumpToDate(Date())
            }
        }
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(vm: DayViewModel.sample, displayDatePicker: .constant(false),
                jumpToDate: { _ in } )
    }
}
