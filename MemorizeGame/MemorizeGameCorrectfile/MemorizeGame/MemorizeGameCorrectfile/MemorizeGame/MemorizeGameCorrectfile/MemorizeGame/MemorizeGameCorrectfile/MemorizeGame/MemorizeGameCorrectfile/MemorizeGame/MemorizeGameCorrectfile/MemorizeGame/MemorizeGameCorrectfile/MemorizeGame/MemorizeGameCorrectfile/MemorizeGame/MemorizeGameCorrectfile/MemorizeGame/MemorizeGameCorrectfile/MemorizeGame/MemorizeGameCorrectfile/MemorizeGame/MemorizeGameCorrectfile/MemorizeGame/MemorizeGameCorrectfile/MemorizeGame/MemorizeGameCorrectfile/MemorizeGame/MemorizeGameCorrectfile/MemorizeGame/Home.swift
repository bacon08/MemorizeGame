//
//  Home.swift
//  MemorizeGame
//
//  Created by Dawn Bacon on 4/13/21.
//

import SwiftUI

struct Home: View {
    @State private var startGame = false
    
    
    
    var body: some View {
        
        let game = EmojiMemoryGame()
        let contentView = EmojiMemoryGameView(viewModel: game)
        
        
        Button("Start Game") {
            self.startGame.toggle()
        } .sheet(isPresented: $startGame, content: {
            contentView
        })
       
        .preferredColorScheme(.dark)
        .foregroundColor(.green)
        
        
        
            
                    
        }
    }


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Home()
            
        }
                
            
            
            
            
    }
}

