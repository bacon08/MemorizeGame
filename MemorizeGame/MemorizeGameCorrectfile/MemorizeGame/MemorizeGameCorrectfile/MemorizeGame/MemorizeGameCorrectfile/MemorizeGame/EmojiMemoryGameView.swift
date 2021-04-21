//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Dawn Bacon on 1/27/21.
//
//1.
//2.
//3.
//4.
//5.
//6.
//7.
import SwiftUI



//all cards combined--valuetypes
struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    
        //All the card view
        var body: some View {
           
            
            //ZStacks groups subviews together vertically, along the vertical axis, so top-to-bottom
            ZStack
            {
                LinearGradient(gradient: .init(colors: [.black,.white,.black]), startPoint: .bottomTrailing,
                               endPoint: .topLeading).edgesIgnoringSafeArea(.all)
            //VStack views together along the z- or depth axis, shown back-to-front
            VStack {
            Grid (viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.60)) {
                    self.viewModel.choose(card: card)
                    }
                }
                .padding(10)
                .foregroundColor(.green)
            }
            
                
            }
        }
           
    }
}
// one card view
struct CardView: View {
    var card: MemoryGame<String>.Card
   
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    
    
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining //percentage left
        withAnimation(.linear(duration: card.bonusTimeRemaining)) { //seconds left
            animatedBonusRemaining = 0
        }
    }
   
   
    @ViewBuilder
   
    
    private func body(for size: CGSize) -> some View{
        if card.isFaceUp || !card.isMatched {
            ZStack{
                Group {
                if card.isConsumingBonusTime {
                    Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                       .onAppear {
                            self.startBonusTimeAnimation()
                        }
                } else {
                    Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                    }
                }
                .padding(5).opacity(0.4)
                Text (card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 :0))
                    .animation(card.isMatched ? Animation.linear(duration:1).repeatForever(autoreverses: false) : .default)
            }
             .cardify(isFaceUp: card.isFaceUp)
             .transition(AnyTransition.scale)
            
        }
    
    }

   
    
            
    
    //MARK: - Drawing Constants
    
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }

}

    struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        
        return EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
                
struct CustomController : UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CustomController>)
    -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Custom", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: "FrontScene")
        return controller
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<CustomController>) {
        
    }
}

    



