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
    
    // Stores the index of the one face-up card. It is set to 'nil' when there are two face-up cards.
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            var faceUpCardIndices = [Int]()
            for index in cards.indices {
                if cards[index].isFaceUp {
                    faceUpCardIndices.append(index)
                }
            }
            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
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
        // 1. find the index of the chosen card from 'cards' array.
        if let chosenIndex = cards.firstIndex(of: card) {
            // 2. If the card is already face-up or if the card is already matched, do nothing.
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                // 3. Check if you already have another face-up card index stored in 'indexOfTheOneAndOnlyFaceUpCard'
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    // 4. There is another face-up card, so try to match both cards.
                    //    a. Try to match them by their content property. If match is successful, set 'isMatched' of both cards to 'true'.
                    //    b. Regardless of the match, store 'nil' in 'indexOfTheOneAndOnlyFaceUpCard' since we have two face-up cards now.
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                } else {
                    // 5. No face-up or there are two face-up cards already, so
                    //    a. Turn all the cards face-down.
                    //    b. store the index of the chosen card in 'indexOfTheOneAndOnlyFaceUpCard', as that is goint to be the only face-up card now.
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                // 6. Turn the currently selected card to face-up.
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
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
