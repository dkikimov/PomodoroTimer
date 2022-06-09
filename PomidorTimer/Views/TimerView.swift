//
//  TimerView.swift
//  PomidorTimer
//
//  Created by Даник 💪 on 09.06.2022.
//

import Foundation
import SwiftUI

struct TimerView: View {
    @StateObject var timerViewModel: TimerViewModel
    
    init(viewModel: TimerViewModel) {
        self._timerViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            Text(timerViewModel.timeLeftText)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            HStack {
                if timerViewModel.isTimerPaused {
                    Button("Возобновить") {
                        timerViewModel.startTimer()
                    }
                } else {
                    Button("Поставить на паузу") {
                        timerViewModel.stopTimer()
                    }
                }
                Button("Остановить") {
                    timerViewModel.stopTimer()
                    timerViewModel.toggleTimerView()
                }
            }
            
        }
        .frame(width: 300, height: 200, alignment: .center)
        
    }
}
