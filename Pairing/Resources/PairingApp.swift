//
//  PairingApp.swift
//  Pairing
//
//  Created by YOUJIM on 2023/07/21.
//

import SwiftUI

@main
struct PairingApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
//            PreRecordingView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
