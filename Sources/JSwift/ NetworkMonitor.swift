//
//  NetworkMonitor.swift
//  JSwift
//
//  Created by Jenya Lebid on 9/6/24.
//

import SwiftUI
import Network

struct NetworkMonitorEnvironmentKey: EnvironmentKey {
    static let defaultValue: NetworkMonitor = .shared
}

public extension EnvironmentValues {
    var networkMonitor: NetworkMonitor {
        get { self[NetworkMonitorEnvironmentKey.self] }
        set { self[NetworkMonitorEnvironmentKey.self] = newValue }
    }
}

@Observable
public class NetworkMonitor {

    public static let shared = NetworkMonitor(label: "JSwift Network Monitor")
    public static var isConnected: Bool { shared.isConnected }

    private var monitor: NWPathMonitor
    private let queue: DispatchQueue

    public private(set) var isConnected: Bool = false
    public private(set) var label: String

    public var isOffline: Bool {
        isConnected == false
    }

    public init(label: String) {
        self.label = label
        self.queue = DispatchQueue(label: label)
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async { [weak self] in
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
    
    deinit {
        monitor.cancel()
    }
}
