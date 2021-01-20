//
//  CoronaVirusApp.swift
//  CoronaVirus
//
//  Created by User01 on 2021/1/8.
//

import SwiftUI
import PartialSheet

@main
struct CoronaVirusApp: App {
    let persistenceController = PersistenceController.shared
    let sheetManager: PartialSheetManager = PartialSheetManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(sheetManager)
                
        }
    }
}
