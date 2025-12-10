//
//  ContentView.swift
//  Memorize
//
//  Created by Mohsin Ali Ayub on 10.12.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView()
            CardView()
            CardView()
            CardView()
        }
        .padding()
        .foregroundStyle(.orange)
    }
}

struct CardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.white)
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(lineWidth: 2)
            Text("👻").font(.largeTitle)
        }
    }
}

#Preview {
    ContentView()
}
