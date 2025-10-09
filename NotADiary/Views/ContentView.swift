//
//  ContentView.swift
//  NotADiary
//
//  Created by Pedro Augusto on 06/10/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                    .padding()
                    .shareSheet(items: ["Hello, word!"])
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
