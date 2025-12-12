//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Mohsin Ali Ayub on 10.12.25.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    var viewModel = EmojiMemoryGame()
    
    var body: some View {
        VStack {
            cards
            Spacer()
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(card: viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundStyle(.orange)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundStyle(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content).font(.largeTitle)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
    }
}

#Preview {
    EmojiMemoryGameView()
}
