//
//  ContentView.swift
//  Habit Grid
//
//  Created by Jude Burdick on 10/9/26.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = HabitViewModel()
    private let columns = Array(
        repeating: GridItem(.flexible()), count: 7
    )
    var body: some View {
        ZStack {
            background
                .ignoresSafeArea()
            ScrollView {
                habitSections
                statsTable
            }
        }
    }
    
    private var statsHeader: some View {
        GridRow {
            Text("Habit")
            Text("Rate")
            Text("Streak")
        }
        .font(.headline).fontDesign(.monospaced)
    }
    
    private func statsRow(habitIndex: Int) -> some View {
        let habit = viewModel.habits[habitIndex]
        return GridRow {
            Text("\(habit.emoji) \(habit.name)")
            Text(habit.completionRate, format: .percent.precision(.fractionLength(0)))
            Text("🔥 \(habit.currentStreak)")
        }
    }
    
    private var statsTable: some View {
        Grid(alignment: .leading, horizontalSpacing: 20, verticalSpacing: 10) {
            statsHeader
            ForEach(viewModel.habits.indices, id: \.self) { habitIndex in
                statsRow(habitIndex: habitIndex)
            }
        }
        .padding()
        .background(.white, in: RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 15)
        .padding()
    }
    
    private func habitgrid(habitIndex: Int) -> some View {
        VStack {
            weekdayHeader
            LazyVGrid(columns: columns) {
                ForEach(0...27, id: \.self) { dayIndex in
                    Button {
                        viewModel.toggleDay(habitIndex: habitIndex, dayIndex: dayIndex)
                    } label: {
                        DayCell(dayNumber: dayIndex + 1, isCompleted: viewModel.habits[habitIndex].completions[dayIndex])
                    }
                }
            }
        }
    }
    
    private func dayButton(habitIndex: Int, dayIndex: Int) -> some View {
        Button {
            viewModel.toggleDay(habitIndex: habitIndex, dayIndex: dayIndex)
        } label: {
            DayCell(dayNumber: dayIndex + 1, isCompleted: viewModel.habits[habitIndex].completions[dayIndex])
        }
    }
    
    private func styledHabitGrid(habitIndex: Int)-> some View {
        habitgrid(habitIndex: habitIndex)
           .foregroundStyle(.white)
           .padding()
           .overlay(
               RoundedRectangle(cornerRadius: 15)
                   .stroke(.white, lineWidth: 1.8)
       )
           .padding()
    }
    
    private var habitSections: some View {
        VStack {
            ForEach(viewModel.habits.indices, id: \.self) { habitIndex in
                VStack {
                    Text("\(viewModel.habits[habitIndex].emoji) \(viewModel.habits[habitIndex].name)")
                        .foregroundStyle(.white)
                        .fontDesign(.monospaced)
                    styledHabitGrid(habitIndex: habitIndex)
                }
            }
        }
    }
    
    private var weekdayHeader: some View {
        LazyVGrid(columns: columns) {
            ForEach(0..<7, id: \.self) { index in
                Text(["S", "M", "T", "W", "T", "F", "S"][index])
                    .font(.caption)
                    .foregroundStyle(.white)
            }
        }
    }
    
    private var background: LinearGradient {
        LinearGradient(colors: [.gray, .white], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

#Preview {
    ContentView()
}
