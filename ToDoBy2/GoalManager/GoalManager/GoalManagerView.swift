//
//  GoalManagerView.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 4/25/23.
//

import SwiftUI

struct GoalManagerView: View {
    
    @ObservedObject var vm: GoalManagerViewModel
    
    var body: some View {
        VStack {
            Text("Goals")
                .customTitleStyle()
            List {
                ForEach(vm.goals) { goal in
                    NavigationLink(goal.title, value: goal.id)
                }
            }
            .navigationDestination(for: GoalModel.ID.self) { id in
                GoalView(vm: vm.createGoalViewModel(id: id))
            }
        }
    }
}

struct GoalManagerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GoalManagerView(vm: GoalManagerViewModel.sample)
        }
    }
}
