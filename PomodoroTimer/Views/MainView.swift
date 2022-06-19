//
//  MainView.swift
//  PomodoroTimer
//
//  Created by Даник 💪 on 09.06.2022.
//

import Foundation
import SwiftUI

struct MainView: View {
    @StateObject var timerViewModel: TimerViewModel
    
    init(viewModel: TimerViewModel) {
        self._timerViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        if timerViewModel.isWorking {
            TimerView(viewModel: timerViewModel)
                .transition(.slide)
        } else {
            StartTimerView(viewModel: timerViewModel)
                .transition(.slide)
        }
            
    }
}
