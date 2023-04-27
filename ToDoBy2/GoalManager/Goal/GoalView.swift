//
//  GoalView.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 4/26/23.
//

import SwiftUI

struct GoalView: View {
    @ObservedObject var vm: GoalViewModel
    
    var body: some View {
        VStack {
            Text(vm.title)
            Text(vm.desc)
            Text("Deadline: \(vm.deadline?.description ?? "None")")
            Text("Priority: \(vm.priority.description)")
            Text(vm.isComplete ? "Complete" : "Incomplete")
            if (vm.isComplete) {
                Text("Completed on \(vm.completedDate?.description ?? "error")")
            }
        }
    }
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView(vm: GoalViewModel.sample)
    }
}
