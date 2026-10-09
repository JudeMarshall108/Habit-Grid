//
//  DayCellView.swift
//  Habit Grid
//
//  Created by Jude Burdick on 10/12/26.
//

import SwiftUI

struct DayCell: View {
    let dayNumber: Int
    let isCompleted: Bool
    var body: some View {
        Capsule()
            .fill(isCompleted ? .teal : .gray.opacity(0.2))
            .overlay(
                Text("\(dayNumber)").foregroundStyle(.white)
            )
            .frame(width: 35, height: 25)
            .scaleEffect(isCompleted ? 1.2 : 1)
            .animation(.easeInOut, value: isCompleted)
    }
}

#Preview {
    DayCell(dayNumber: 2, isCompleted: true)
}
