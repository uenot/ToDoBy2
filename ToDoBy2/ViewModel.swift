//
//  ViewModel.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 1/15/23.
//

import SwiftUI

@MainActor final class ViewModel<Model, Action>: ObservableObject {
    @Published private(set) var model: Model
    
    typealias Reducer = (inout Model, Action) -> Void
    let reducer: Reducer
    
    init(model: Model, reducer: @escaping Reducer) {
        self.model =  model
        self.reducer = reducer
    }
    
    func send(_ action: Action) {
        reducer(&model, action)
    }
   
    func createSubViewModel<SubModel, SubAction>(
        _ deriveModel: @escaping (Model) -> SubModel,
        _ translateAction: @escaping (SubAction) -> Action
    ) -> ViewModel<SubModel, SubAction> {
        let vm = ViewModel<SubModel, SubAction>(
            model: deriveModel(model),
            reducer: { _, action in
                self.send(translateAction(action))
            }
        )
        return vm
    }
    
    func binding<Value>(
        for keyPath: KeyPath<Model, Value>,
        convertToAction: @escaping (Value) -> Action
    ) -> Binding<Value> {
        Binding<Value> {
            self.model[keyPath: keyPath]
        } set: { newValue in
            self.send(convertToAction(newValue))
        }
    }
}
