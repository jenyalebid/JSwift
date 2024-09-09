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
}
