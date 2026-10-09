//
//  HabitViewModel.swift
//  Habit Grid
//
//  Created by Jude Burdick on 10/12/26.
//

import Observation

@Observable
class HabitViewModel {
    private(set) var habits: [Habit] = [
        Habit(name: "Reading",
              emoji: "📚",
              completions: (0...27).map { $0 >= 24 }),
        
        Habit(name: "Call Mom",
              emoji: "👩",
              completions: (0...27).map { $0 % 2 == 0 })
    ]
    
    func toggleDay(habitIndex: Int, dayIndex: Int) {
        habits[habitIndex].completions[dayIndex].toggle()
    }
}
