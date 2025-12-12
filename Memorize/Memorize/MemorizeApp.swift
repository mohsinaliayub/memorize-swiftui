//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Mohsin Ali Ayub on 10.12.25.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject private var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
