//
//  TimerViewModel.swift
//  PomidorTimer
//
//  Created by Даник 💪 on 09.06.2022.
//

import Foundation

let workingTime = 60 * 25
let chillingTime = 60 * 5

class TimerViewModel: ObservableObject {
    @Published var timeLeftText: String
    @Published var isWorking = false
    @Published var isTimerPaused = false
    @Published var currentType: TimerType
    
    private var timer = Timer()
    private var secondsLeft: TimeInterval
    private let formatter = DateComponentsFormatter()
    init() {
        formatter.allowedUnits = [.minute, .second]
        currentType = .working
        secondsLeft = TimeInterval(workingTime)
        timeLeftText = formatter.string(from: secondsLeft)!
    }
    
    public func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        isTimerPaused = false
    }
    
    public func stopTimer() {
        timer.invalidate()
        isTimerPaused = true
    }
    
    public func toggleTimerView() {
        toggleWorkingMode()
        isWorking.toggle()
    }
    
    
    public func toggleChillingMode() {
        currentType = .chilling
        secondsLeft = TimeInterval(chillingTime)
    }
    public func toggleWorkingMode() {
        currentType = .working
        secondsLeft = TimeInterval(workingTime)
        timeLeftText = formatter.string(from: secondsLeft)!
    }
    
    @objc private func timerAction() {
        guard secondsLeft > 1 else {
            switch currentType {
            case .working:
                toggleChillingMode()
            case .chilling:
                toggleWorkingMode()
            }
            return
        }
        secondsLeft -= 1
        timeLeftText = formatter.string(from: secondsLeft)!
    }
}
