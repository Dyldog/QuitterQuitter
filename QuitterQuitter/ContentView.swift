//
//  ContentView.swift
//  QuitterQuitter
//
//  Created by Dylan Elliott on 1/7/2024.
//

import SwiftUI

struct QuittingMilestone {
    let length: TimeInterval
    
    init(_ length: TimeInterval) {
        self.length = length
    }
}

struct ContentView: View {
    let quitDate: Date
    let clearTapped: () -> Void
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    let milestones: [QuittingMilestone] = [
        .init(.oneHour),
        .init(.oneDay),
        .init(2.0 * .oneDay),
        .init(3.0 * .oneDay),
        .init(5.0 * .oneDay),
        .init(.oneWeek),
        .init(2.0 * .oneWeek),
        .init(.oneMonth),
        .init(2.0 * .oneMonth),
        .init(3.0 * .oneMonth),
        .init(6.0 * .oneMonth),
        .init(9.0 * .oneMonth),
        .init(.oneYear)
    ]
    
    var timeSinceQuit: TimeInterval { abs(quitDate.timeIntervalSinceNow) }
    
    var nextMilestone: QuittingMilestone! {
        return milestones.first { timeSinceQuit < $0.length }
    }
    
    var timeUntilTextMilestone: TimeInterval {
        nextMilestone.length - timeSinceQuit
    }
    
    @ViewBuilder
    func LargeText(_ string: String) -> some View {
        Text(string)
            .font(.largeTitle).bold()
            .multilineTextAlignment(.center)
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            if let nextMilestone {
                LargeText("\(timeUntilTextMilestone.naturalDescription) until")
                LargeText("\(nextMilestone.length.naturalDescription) nicotine free")
                    .padding(.bottom, 6)
                    
                Text("Since you quit on \(dateFormatter.string(from: quitDate))")
                    .foregroundStyle(.gray)
                    .padding(.top, 0)
            } else {
                LargeText("Error!")
            }
            
            Spacer()
            
            Button("Reset") {
                clearTapped()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView(quitDate: .now) { }
}

extension TimeInterval {
    var naturalDescription: String {
        let descriptions: [(TimeInterval, String)] = [
            (.oneYear, "Year"),
            (.oneMonth, "Month"),
            (.oneWeek, "Week"),
            (.oneDay, "Day"),
            (.oneHour, "Hour"),
            (.oneMinute, "Minute"),
            (1, "Second")
        ]
        
        let unit = descriptions.first { self > $0.0 }!
        
        let count = Int((self / unit.0).rounded(.toNearestOrAwayFromZero))
        
        return "\(count) \(unit.1)\(count == 1 ? "" : "s")"
    }
}
