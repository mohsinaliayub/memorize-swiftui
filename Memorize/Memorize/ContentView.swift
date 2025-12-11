//
//  ContentView.swift
//  Memorize
//
//  Created by Mohsin Ali Ayub on 10.12.25.
//

import SwiftUI

struct ContentView: View {
    private let emojis = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"]
    @State private var cardCount = 4
    
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<cardCount, id: \.self) { index in
                    CardView(content: emojis[index], isFaceUp: true)
                }
            }
            .foregroundStyle(.orange)
            
            HStack {
                Button("Remove Card") {
                    cardCount -= 1
                }
                Spacer()
                Button("Add Card") {
                    cardCount += 1
                }
            }
        }
        .padding()
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
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
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
