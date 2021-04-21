//
//  EmojiMemoryGame.swift
//  Memorize
//  Draws the emoji
//  Created by Dawn Bacon on 1/28/21.
//

import SwiftUI


//Accesc ontrol = private
class EmojiMemoryGame:  ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String> {
        
        let emojis: Array<String> = ["☠️","😵", "👹", "🤯", "😈", "🥸"]
    
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
            
    }
}
    
    
    
 
    //MARK: -Access to the Model
    
    var cards: Array<MemoryGame<String>.Card>{
        model.cards
        
    }
    
    // MARK: -Intent(s)
    
    
    func choose(card:MemoryGame<String>.Card) {
        model.choose(card: card)
        
        
    }
    func resetGame() {
        model =  EmojiMemoryGame.createMemoryGame()
    }
    
}

