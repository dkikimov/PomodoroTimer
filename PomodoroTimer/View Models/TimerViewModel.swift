//
//  TimerViewModel.swift
//  PomodoroTimer
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
        toggleWorkingMode(withNotification: false)
        isWorking.toggle()
    }
    
    private func toggleChillingMode(withNotification: Bool) {
        currentType = .chilling
        secondsLeft = TimeInterval(chillingTime)
        timeLeftText = formatter.string(from: secondsLeft)!
        if withNotification { NotificationManager.shared.showChillingStarted() }
    }
    private func toggleWorkingMode(withNotification: Bool) {
        currentType = .working
        secondsLeft = TimeInterval(workingTime)
        timeLeftText = formatter.string(from: secondsLeft)!
        if withNotification { NotificationManager.shared.showWorkingStarted() }
    }
    
    @objc private func timerAction() {
        guard secondsLeft > 1 else {
            changeMode(withNotification: true)
            return
        }
        secondsLeft -= 1
        timeLeftText = formatter.string(from: secondsLeft)!
        
        switch secondsLeft {
        case TimeInterval(5*60):
            NotificationManager.shared.showMinutesAlert(minutes: 5)
        case TimeInterval(60):
            NotificationManager.shared.showMinutesAlert(minutes: 1)
        default:
            break
        }
    }
    
    public func changeMode(withNotification: Bool) {
        switch currentType {
        case .working:
            toggleChillingMode(withNotification: withNotification)
        case .chilling:
            toggleWorkingMode(withNotification: withNotification)
        }
    }
}
