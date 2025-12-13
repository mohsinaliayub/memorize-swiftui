//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Mohsin Ali Ayub on 12.12.25.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    // TODO: - Write Documentation for this method.
    // Gameplay rules: (All cards need to be face-down when the app starts)
    // 1. When player chooses a first card, you should face it up.
    // 2. When player chooses a second card, you have to make a match b/w the two face-up cards.
    // 3. When player chooses a third card, the previous two-cards must be face down.
    //
    // Matching Rules: What to do in step 2 of the gameplay rules.
    // a. If there's a match b/w the two face-up cards, you should face-them down, and preferrably remove/hide from the deck of cards.
    // b. If there's no match, do nothing and go to step 3 when player chooses the next card.
    //
    // Some extra rules.
    // - If there's a card that's already matched and the user taps it, do nothing.
    // - Also, if the player taps the same card that's already face-up, do nothing.
    //
    // In a nutshell: you can only match a card with another card if there's only one extra face-up card.
    //                - At one time, there can be only two cards that are face-up.
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(of: card) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        let id: String
        
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
    }
}


extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
