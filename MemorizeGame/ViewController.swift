//
//  ViewController.swift
//  MemorizeGame
//
//  Created by Dawn Bacon on 4/14/21.
//

import UIKit
import SwiftUI
import Foundation


    //meeh
class ViewController: UIViewController {
    
  
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var theContainer : UIView!
    
    
    
    
    var timer: Timer?
    var milliseconds: Float = 25 * 1000 //10 seconds
    
    
   override func viewDidLoad() {
        super.viewDidLoad()
        
        let childView = UIHostingController(rootView: EmojiMemoryGameView(viewModel: EmojiMemoryGame()))
        
        addChild(childView)
        childView.view.frame = theContainer.bounds
        theContainer.addSubview(childView.view)

        // Do any additional setup after loading the view.
        
        //create timer
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    //Mark: - Tiimer Methods
    
    @objc func timerElapsed () {
        
        milliseconds -= 1
        
        //Convert to seconds
        let seconds = String(format: "%.2f", milliseconds/1000)
        
        //Set label
        timerLabel.text = "Time Remaining: \(seconds)"
        
        //when the timer has reached 0..
        if milliseconds <= 0 {
            
        //stop the timer
        timer?.invalidate()
        timerLabel.textColor = UIColor.red
        checkGameEnded()
            
      
            
        }
}
    
    //Array<MemoryGame<String>.Card>()
    func checkGameEnded() {
        
        
        var iswon = true
        
            for card in Array<MemoryGame<String>.Card>() {
                print(card.isMatched)
                if card.isMatched == true  {
                iswon = true
                break
        
    }
            }

        
        
    var title = ""
    var message = ""
        
    if iswon == true {
        
            if milliseconds > 0 {
            
                milliseconds = 0
        //timer?.invalidate()
    
        }
        
        title = "Congratulations!"
        message = "You've won!!!"
        
        }
    else {
        
        if milliseconds  > 0 {
            return
        }
        
        title = "Game Over"
        message = "You've lost"
            
        }
        
        showAlert(title: title, message: message)
     
        }
    public func showAlert( title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)

    }
    

}



    

    /*
 / MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



