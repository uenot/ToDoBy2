//
//  Destinations.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 4/19/23.
//

import SwiftUI

enum Destination {
    case mainTM
    case recurring
    case deadlines
    case goals
    case about
    case credits
}

extension Destination: Hashable, Identifiable {
    var id: Self { self }
}

extension Destination: CustomStringConvertible {
    var description: String {
        switch self {
        case .mainTM:
            return "Main Task Manager"
        case .recurring:
            return "Recurring/Daily Tasks"
        case .deadlines:
            return "Deadlines"
        case .goals:
            return "Goals"
        case .about:
            return "About"
        case .credits:
            return "Credits"
        }
    }
}

extension Sidebar {
    struct Constants {
        static let destinations: [[Destination]] = [
            [.mainTM, .recurring, .deadlines, .goals],
            [.credits]
        ]
    }
}
