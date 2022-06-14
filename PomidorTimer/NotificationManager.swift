//
//  NotificationManager.swift
//  PomodoroTimer
//
//  Created by Даник 💪 on 09.06.2022.
//

import Foundation
import UserNotifications


class NotificationManager {
    static let shared = NotificationManager()
    
    let un = UNUserNotificationCenter.current()
    func requestAllow() {
        un.requestAuthorization(options: [.alert, .sound]) { (authorized, error) in
            if authorized {
                print("Authorized")
            } else if !authorized {
                print ("Not authorized")
            } else {
                print (error?.localizedDescription as Any)
            }
        }
    }
    
    private func show(title: String!, body: String!, withSound: Bool = true) {
        let content = UNMutableNotificationContent();
        content.title = title
        content.body = body
        if withSound {
            content.sound = UNNotificationSound.defaultCritical
        };
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false);
        
        let uuidString = UUID().uuidString ;
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger);
        
        self.un.add(request, withCompletionHandler: { (error) in
            if error != nil
            {
                // Something went wrong
            }
        })
    }
    
    func showChillingStarted() {
        show(title: "Началось время отдыха", body: "Пора отдыхать! У вас есть 5 минут. Можете прогуляться или поделать физические упражнения")
    }
    
    func showWorkingStarted() {
        show(title: "Началось время работы", body: "Можно обратно сесть за компьютер!")
    }
    
    func showMinutesAlert(minutes: Int) {
        show(title: "Внимание!", body: "Осталось \(minutes) минут перед началом следующего этапа")
    }
    
    
}

