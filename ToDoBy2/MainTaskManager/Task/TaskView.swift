//
//  TaskView.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 1/15/23.
//

import SwiftUI

struct TaskView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var vm: TaskViewModel
    @State private var tempTitle: String
    
    init(vm: TaskViewModel) {
        self.vm = vm
        self._tempTitle = State(initialValue: vm.title)
    }
    
    var body: some View {
        VStack {
            TextField("Edit Title", text: $tempTitle)
                .onChange(of: tempTitle) { newTitle in
                    vm.send(.editTitle(newTitle))
                }
                .multilineTextAlignment(.center)
            Group {
                if (vm.isComplete) {
                    Text("Complete").foregroundColor(.green)
                } else {
                    Text("Incomplete").foregroundColor(.indigo)
                }
            }
            .padding()
            Button(vm.isComplete
                   ? "Mark as Incomplete"
                   : "Mark as Complete") {
                if (vm.isComplete) {
                    vm.send(.markIncomplete)
                } else {
                    vm.send(.markComplete)
                }
            }
            Button {
                vm.send(.deleteSelf)
                dismiss()
            } label: {
                Text("Delete")
                    .foregroundColor(.red)
            }
            .padding()
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(vm: TaskViewModel.sample)
    }
}
