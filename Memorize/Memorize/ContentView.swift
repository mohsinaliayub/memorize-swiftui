//
//  ContentView.swift
//  Memorize
//
//  Created by Mohsin Ali Ayub on 10.12.25.
//

import SwiftUI

struct ContentView: View {
    private let emojis = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙‍♀️", "🙀", "👹", "☠️", "🍭"]
    
    var body: some View {
        HStack {
            CardView(content: emojis[0])
            CardView(content: emojis[1])
            CardView(content: emojis[2], isFaceUp: true)
            CardView(content: emojis[3], isFaceUp: true)
        }
        .padding()
        .foregroundStyle(.orange)
    }
}

struct CardView: View {
    let content: String
    var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.foregroundStyle(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            } else {
                base.fill()
            }
        }
        .onTapGesture {
//            isFaceUp.toggle() // Error - Cannot assign to property: 'self' is immutable
        }
    }
}

#Preview {
    ContentView()
}
