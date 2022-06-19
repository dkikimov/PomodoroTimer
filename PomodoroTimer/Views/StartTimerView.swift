//
//  TimerView.swift
//  PomodoroTimer
//
//  Created by Даник 💪 on 09.06.2022.
//

import Foundation
import SwiftUI

struct StartTimerView: View {
    @StateObject var timerViewModel: TimerViewModel
    
    init(viewModel: TimerViewModel) {
        self._timerViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            Text("Поработаем?")
                .font(.largeTitle)
                .fontWeight(.bold)
                
            Button("Запустить таймер") {
                timerViewModel.startTimer()
                timerViewModel.toggleTimerView()
            }
        }
        .frame(width: 300, height: 200, alignment: .center)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        StartTimerView(viewModel: TimerViewModel())
    }
}

