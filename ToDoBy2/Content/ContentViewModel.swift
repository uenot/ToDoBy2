//
//  ContentViewModel.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 4/24/23.
//

import Foundation

typealias ContentViewModel = ViewModel<ContentModel, ContentModel.Action>

extension ContentViewModel {
    func createTaskManagerViewModel() -> TaskManagerViewModel {
        let convertModel: (ContentModel) -> TaskManagerModel = { model in
            return model.taskManager
        }
        let convertAction: (TaskManagerModel.Action) -> ContentModel.Action = { action in
                .editTaskManager(action)
        }
        return createSubViewModel(convertModel, convertAction)
    }
    
    func createGoalManagerViewModel() -> GoalManagerViewModel {
        let convertModel: (ContentModel) -> GoalManagerModel = { model in
            model.goalManager
        }
        let convertAction: (GoalManagerModel.Action) -> ContentModel.Action = { action in
                .editGoalManager(action)
        }
        return createSubViewModel(convertModel, convertAction)
    }
    
    private func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("content.json")
    }
    
    func load() async -> Void {
        let newModel = await Task(priority: .background) {
            do {
                let url = try fileURL()
                let file = try FileHandle(forReadingFrom: url)
                let result = try JSONDecoder().decode(ContentModel.self, from: file.availableData)
                return result
            } catch {
                print(error.localizedDescription)
                return ContentModel.sample
            }
        }.value
        self.send(.load(newModel))
    }
    
    func save() async -> Void {
        Task(priority: .background) {
            do {
                let data = try JSONEncoder().encode(model)
                let url = try fileURL()
                try data.write(to: url)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension ContentViewModel {
    static let sample = ContentViewModel(model: ContentModel.sample, reducer: ContentModel.reducer)
}
