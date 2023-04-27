//
//  TaskManagerViewConstants.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 3/2/23.
//

import SwiftUI

extension TaskManagerView {
    struct Constants {
        static let slideDuration = 0.35
        static var slideAnimation: Animation {
            .easeOut(duration: slideDuration)
        }
        static let offsetRatio: CGFloat = 1/3
        static let predictedOffsetRatio: CGFloat = 0.9
    }
}
