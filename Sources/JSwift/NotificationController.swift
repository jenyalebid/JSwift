//
//  NotificationController.swift
//  JSwift
//
//  Created by Jenya Lebid on 9/8/24.
//

import Foundation
import NotificationCenter

final public class NotificationController {
    
    let center = UNUserNotificationCenter.current()
    public static let shared = NotificationController()

    private init() {}
    
    public func request() async throws -> Bool  {
        try await center.requestAuthorization(options: [.alert, .sound, .badge])
    }
    
    public func checkPermission(completion: @escaping (UNAuthorizationStatus) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus)
            }
        }
    }
    
    public func cancelFor(identifier: String) {
           UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
       }
    
    public func scheduleDaily(hour: Int, minute: Int, title: String, message: String, id: String) {
        // Create the notification content
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        content.sound = .default
        
        // Create the date components for the reminder time
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        // Create a trigger that fires daily at the specified time
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Create a unique identifier for the notification
        let identifier = id
        
        // Create the notification request
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        // Add the notification request to the notification center
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("ERROR scheduling daily reminder: \(error.localizedDescription)")
            }
        }
    }
}
