//
//  NetworkMonitor.swift
//  JSwift
//
//  Created by Jenya Lebid on 9/6/24.
//

import SwiftUI
import Network

struct NetworkMonitorEnvironmentKey: EnvironmentKey {
    static let defaultValue: NetworkMonitor = NetworkMonitor()
}

public extension EnvironmentValues {
    var networkMonitor: NetworkMonitor {
        get { self[NetworkMonitorEnvironmentKey.self] }
        set { self[NetworkMonitorEnvironmentKey.self] = newValue }
    }
}

@Observable
public class NetworkMonitor {
    
    private var monitor: NWPathMonitor
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    public private(set) var isConnected: Bool = false
    
    public var isOffline: Bool {
        isConnected == false
    }

    init() {
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
