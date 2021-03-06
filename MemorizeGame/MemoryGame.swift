//
//  MemoryGameStruct.swift
//  Memorize
//  THe game play
//  Created by Dawn Bacon on 1/28/21.
//
import UIKit
import SwiftUI
import Foundation

//Brian Waz Here



struct MemoryGame<CardContent> where CardContent: Equatable {
    
    public var cards: Array<Card>
    
    
    
     var indexOFTheOneAndOnlyFaceUpCard: (Int?) {
        
        get {cards.indices.filter { cards[$0].isFaceUp}.only }
        set {
            
            for index in cards.indices {
            
            cards[index].isFaceUp = index == newValue
            }
      }
        
}
   
    
    
 
    
   
// card function where if it matches or not]

     mutating func choose(card: Card) {
        
      //lol
        sounds.playSounds(soundfile: "click.mp3")
        
        if let chosenIndex = cards.firstindex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            
            if let potentialMatchIndex = indexOFTheOneAndOnlyFaceUpCard
            {
                
                if cards[chosenIndex].content == cards[potentialMatchIndex].content
                
                {
                    
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    sounds.playSounds(soundfile: "match.mp3")
                    //ViewController().checkGameEnded()
                }
                
                if !cards[chosenIndex].isFaceUp == !cards[potentialMatchIndex].isMatched
                
                {
                    sounds.playSounds(soundfile: "buzzer.mp3")
                    
                }
                
                self.cards[chosenIndex].isFaceUp = true
               
               }
                else {
                indexOFTheOneAndOnlyFaceUpCard = chosenIndex
                
                    
                    
                    
                } 
           
           
            
        }
        
    }
    
    
    
//initialize
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
            
           
        }
        
        cards.shuffle()
        sounds.playSounds(soundfile: "shufflingcards.mp3")
        
        }

   
    
    
    struct Card: Identifiable
        {
        
        var isFaceUp: Bool = false
        
        {
            didSet
            {
                if isFaceUp
                {
                    
                    startUsingBonusTime()
                    
                }
                else
                {
                    
                    stopUsingBonusTime()
                    
                }
            }
        }
        
        var isMatched: Bool = false
        
        {
         didSet
            {
            
                stopUsingBonusTime()
              
            }
            
        }
    
        
        
        var content: CardContent
        var id: Int
        
        
       
    
                
            
    
      
    
        
       
        
        
        //MARK: - Bonus Time
            
            //this could give matching bonus points, if the user matches the cards
            //before a certain amount of time passes during when the card is facing up

            //can be zero whichmean no bonus available for the card
            var bonusTimeLimit: TimeInterval = 6
            
            //how long the card has ever been face up
            private var FaceUpTime: TimeInterval {
                if let lastfaceUpDate = self.lastFaceUpDate {
                    return pastFaceUpTime + Date ().timeIntervalSince(lastfaceUpDate)
                } else {
                    return pastFaceUpTime
                }
            }
            //the last time the card was face up and still is up
            var lastFaceUpDate: Date?
            //the amount of time this card has been face up in the past
            //not including the current time its been face up if it is currently
            var pastFaceUpTime: TimeInterval = 0
            
            //how much time left before the bonus oppertunity runs  out
            var bonusTimeRemaining: TimeInterval {
                Swift.max(0, bonusTimeLimit - FaceUpTime)
            }
            
            //percentage of the bonus time remaining
            var bonusRemaining: Double {
                (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
            }
            //whether the card was matched during the bonus time period
            var hasEarnedBonus: Bool {
                isMatched && bonusTimeRemaining > 0
            }
            
            //whether we are currently face up, unmatched and have not yet used up the bonus window
            var isConsumingBonusTime: Bool {
                isFaceUp && !isMatched && bonusTimeRemaining > 0
            }
            
            //called when the card transitions to face up state
            private mutating func startUsingBonusTime(){
                if isConsumingBonusTime, lastFaceUpDate == nil {
                        lastFaceUpDate = Date ()
                }
            }
            
            //called when the card goes back from face down (or gets matched)
            private mutating func stopUsingBonusTime() {
                pastFaceUpTime = FaceUpTime
                self.lastFaceUpDate = nil
                }
            }

            
}




