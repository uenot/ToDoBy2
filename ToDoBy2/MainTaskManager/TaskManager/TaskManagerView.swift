//
//  TaskManagerView.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 1/15/23.
//

import SwiftUI

struct TaskManagerView: View {
    
    @ObservedObject var vm: TaskManagerViewModel
    
    @State private var displayDatePicker = false
    
    @GestureState private var translation: CGFloat = 0
    @State private var offset: CGFloat = 0
    
    func swipeGesture(width: CGFloat) -> some Gesture {
        DragGesture(minimumDistance: 30).updating($translation) { value, state, _ in
            let translation = min(width, max(-width, value.translation.width))
            state = translation
        } .onEnded { value in
            offset = min(width, max(-width, value.translation.width))
            let predictedOffset = value.predictedEndTranslation.width
            if (offset/width < -Constants.offsetRatio
                || predictedOffset/width < -Constants.predictedOffsetRatio) {
                changeDay(to: vm.currentDate + 1, width: width)
            } else if (offset/width > Constants.offsetRatio
                       || predictedOffset/width > Constants.predictedOffsetRatio) {
                changeDay(to: vm.currentDate - 1, width: width)
            } else {
                changeDay(to: vm.currentDate, width: width)
            }
        }
    }
    
    // uhmm if you print the window we get day, day+1, day+2
    // should be day-1, day, day+1
    // why? and why does it still work????
    @State private var window: [DayModel] = []
    
    func setWindow(to date: Date) {
        window.removeAll()
        for i in -1...1 {
            let day = vm.getDay(for: date + i)
            window.append(day)
        }
    }
    
    func changeDay(to date: Date, width: CGFloat) {
        if (Calendar.current.compare(date, to: vm.currentDate, toGranularity: .day) == .orderedDescending){
            window[2] = vm.getDay(for: date)
            withAnimation(Constants.slideAnimation) {
                offset = -width
            }
        } else if (Calendar.current.compare(date, to: vm.currentDate, toGranularity: .day) == .orderedAscending) {
            window[0] = vm.getDay(for: date)
            withAnimation(Constants.slideAnimation) {
                offset = width
            }
        } else {
            withAnimation(Constants.slideAnimation) {
                offset = 0
            }
        }
        // concurrency issues: what happens when swiping twice quickly?
        // should cancel all previous shifts, only take most recent swipe
        Task {
            try await Task.sleep(until: .now + .seconds(Constants.slideDuration), clock: .continuous)
            vm.send(.setDate(date))
            setWindow(to: date)
            offset = 0
        }
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    ForEach(window) { day in
                        DayView(vm: vm.createDayViewModel(day: day),
                                displayDatePicker: $displayDatePicker,
                                jumpToDate: { d in changeDay(to: d, width: geometry.size.width) })
                            .frame(width: geometry.size.width)
                    }
                }
                .frame(width: geometry.size.width, alignment: .center)
                .offset(x: translation+offset)
                .gesture(swipeGesture(width: geometry.size.width))
            }
        }
        .navigationDestination(for: TaskModel.ID.self) { id in
            TaskView(vm: vm.createTaskViewModel(id: id))
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    withAnimation {
                        displayDatePicker.toggle()
                    }
                } label: {
                    Image(systemName: "calendar")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
        .onChange(of: vm.currentDate) { _ in
            displayDatePicker = false
//            setWindow(to: vm.currentDate) // necessary for first load-in
        }
        .onAppear {
            setWindow(to: vm.currentDate)
        }
    }
}

struct TaskManagerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TaskManagerView(vm: TaskManagerViewModel.sample)
        }
    }
}
