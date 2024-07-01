//
//  SetQuitDateView.swift
//  QuitterQuitter
//
//  Created by Dylan Elliott on 1/7/2024.
//

import SwiftUI

struct SetQuitDateView: View {
    
    @State var quitDate: Date
    
    var completion: (Date) -> Void
    
    var body: some View {
        VStack {
            DatePicker("Quit date", selection: $quitDate)
                .labelsHidden()
            Button {
                completion(quitDate)
            } label: {
                Text("I Quit!")
                    .font(.largeTitle.bold())
            }

        }
    }
}
