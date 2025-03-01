//
//  LockInStatsApp.swift
//  LockInStats
//
//  Created by Danielle Abrams on 10/4/24.
//

import SwiftUI

@main
struct LockInStatsApp: App {
    @StateObject var VM = LockInVM()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(VM)
        }
    }
}
