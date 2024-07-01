//
//  QuitterQuitterApp.swift
//  QuitterQuitter
//
//  Created by Dylan Elliott on 1/7/2024.
//

import SwiftUI
import DylKit

enum DefaultsKeys: String, DefaultsKey {
    case quitDate
}

class QuitterQuitterAppModel: ObservableObject {
    var quitDate: Date? {
        get {
            try? UserDefaults.standard.value(for: DefaultsKeys.quitDate)
        }
        set {
            objectWillChange.send()
            try? UserDefaults.standard.set(newValue, for: DefaultsKeys.quitDate)
        }
    }
}

@main
struct QuitterQuitterApp: App {
    
    @StateObject var model: QuitterQuitterAppModel = .init()
    @State var defaultDate: Date = .now
    
    var body: some Scene {
        WindowGroup {
            switch model.quitDate {
            case .none:
                SetQuitDateView(quitDate: defaultDate) {
                    model.quitDate = $0
                }
            case let .some(date):
                ContentView(quitDate: date) {
                    defaultDate = date
                    model.quitDate = nil
                }
            }
        }
    }
}
