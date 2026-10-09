//
//  Habit.swift
//  Habit Grid
//
//  Created by Jude Burdick on 10/9/26.
//

import Foundation

struct Habit : Identifiable {
    let id: UUID = UUID()
    var name: String
    var emoji: String
    var completions = Array(repeating: false, count: 28)
    
    var completedCount: Int { get {
        completions.filter { $0 }.count }
    }
    
    var completionRate: Double {
        min(max(Double(completedCount) / Double(completions.count), 0), 1)
    }
    
    var currentStreak: Int { get {
        var streak = 0
        for index in completions.indices.reversed() {
            if !completions[index] { break }
            streak += 1
        }
        return streak }
    }
}
