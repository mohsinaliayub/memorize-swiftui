//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Mohsin Ali Ayub on 12.12.25.
//

import Foundation

class EmojiMemoryGame {
    // TODO: Finish the implementation
    private var model = MemoryGame<String>(numberOfPairsOfCards: 4)
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
