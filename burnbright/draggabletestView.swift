//
//  draggabletestView.swift
//  burnbright
//
//  Created by Aksharaa Ramesh on 5/6/26.
//

//Logic to implement: you can have any amt of cards in your deck, but the only cards whose numbers you can see/are allowed to use are the 4??? ask rohini how this works again
import SwiftUI
import CoreTransferable
import UniformTypeIdentifiers

struct TransferableInt: Transferable, Codable {
    let value: Int
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .plainText)
    }
}

struct draggabletestView: View {
    @State var topDeck: [Int] = [] //to obtain no. of cards, use topDeck.count
    @State var firstmainPile: Int = Int.random(in: 0...9)
    @State var secondmainPile: Int = Int.random(in: 0...9)
    @State var cardsInPiles: [Int] = []
    @State var bottomDeck: [Int] = (0..<4).map{ _ in
        Int.random(in: 0...9)
    }
    var body: some View {
        VStack{
//            KanbanView(cards: topDeck, kandim:[390.0, 150.0], carddim: [20, 40], textsize: 30)
            Spacer()
            Text("Opponent has \(topDeck.count) cards left!")
                .font(.system(size: 33))
                .foregroundColor(.red)
           // Text("\(cardsInPiles)")
            Spacer()
            
            HStack {
                Spacer()
                MainPileView(card: firstmainPile, kandim:[170.0, 240.0], carddim: [130.0, 200.0], textsize: 30)
                    .contentShape(Rectangle())
                    .dropDestination(for: TransferableInt.self) { droppedCards, location in
                        let value = droppedCards.first?.value ?? 0
                        if (firstmainPile - 1) == value{
                            cardsInPiles.append(value)
                            firstmainPile = value
                            //bottomDeck.removeAll(where: { $0 == value })
                            if let index = bottomDeck.firstIndex(of: value) {
                                bottomDeck.remove(at: index)
                                bottomDeck.append(Int.random(in: 0...9))
                            }
                        }else if (firstmainPile + 1) == value{
                            cardsInPiles.append(value)
                            firstmainPile = value
                            if let index = bottomDeck.firstIndex(of: value) {
                                bottomDeck.remove(at: index)
                                bottomDeck.append(Int.random(in: 0...9))
                            }
                        }else{
                        }
                        
                        //
                        
                        return true
                    }
                Spacer()
                MainPileView(card: secondmainPile, kandim:[170.0, 240.0], carddim: [130.0, 200.0], textsize: 30)
                    .contentShape(Rectangle())
                    .dropDestination(for: TransferableInt.self) { droppedCards, location in
                        let value = droppedCards.first?.value ?? 0
                        if (secondmainPile - 1) == value{
                            cardsInPiles.append(value)
                            secondmainPile = value
                            //bottomDeck.removeAll(where: { $0 == value })
                            if let index = bottomDeck.firstIndex(of: value) {
                                bottomDeck.remove(at: index)
                                bottomDeck.append(Int.random(in: 0...9))
                            }
                        }else if (secondmainPile + 1) == value{
                            cardsInPiles.append(value)
                            secondmainPile = value
                            if let index = bottomDeck.firstIndex(of: value) {
                                bottomDeck.remove(at: index)
                                bottomDeck.append(Int.random(in: 0...9))
                            }
                        }else{
                        }
                        
                        //
                        
                        return true
                    }
                Spacer()
            }
            Spacer()
            if firstmainPile == secondmainPile{
                Button("Stress!"){
                    topDeck.append(contentsOf:cardsInPiles)
                    cardsInPiles = []
                    firstmainPile = Int.random(in: 0...9)
                    secondmainPile = Int.random(in: 0...9)
                }
            }
            Spacer()
            KanbanView(cards: bottomDeck, kandim:[390.0, 150.0], carddim: [20, 40], textsize: 30)
                //sth wrong here but idk what, "Adding 'UIView' as a subview of UIHostingController.view is not supported and may result in a broken view hierarchy. Add your view above UIHostingController.view in a common superview or insert it into your SwiftUI content in a UIViewRepresentable instead."
            
        }
    }
}
struct KanbanView: View {
    let cards: [Int]
    let kandim: [Double]
    let carddim: [Double]
    let textsize: Double
    var body: some View {
        VStack (alignment: .leading){
                    HStack(alignment: .center, spacing: 12) {
                        Spacer()
                        ForEach(cards, id: \.self){ card in
                            Text(String(card))
                                .frame(width: carddim[0], height: carddim[1])
                                .padding(12)
                                .background(Color(uiColor: .secondarySystemGroupedBackground))
                                .cornerRadius(8)
                                .shadow(radius: 1, x: 1, y: 1)
                                .font(.system(size: textsize))
                                .draggable(TransferableInt(value:card)){
                                    Text(String(card))
                                        .padding(12)
                                        .background(.thinMaterial)
                                        .cornerRadius(8)
                                }
                            
                        }
                        Spacer()
                    }
                    .padding(.vertical)
//                .frame(width: kandim[0], height: kandim[1])
//                .background(Color(.secondarySystemFill))
//                .cornerRadius(15)
            Text("\(cards.count) cards")
                .font(.system(size: 15))
                .offset(x: 320)
                .foregroundColor(.black)
            }
        .frame(width: kandim[0], height: kandim[1])
        .background(Color(.secondarySystemFill))
        .cornerRadius(15)
    }
}
struct MainPileView: View {
    let card: Int
    let kandim: [Double]
    let carddim: [Double]
    let textsize: Double
    var body: some View {
        VStack (alignment: .leading){
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: kandim[0], height: kandim[1])
                    .foregroundColor(Color(.secondarySystemFill))
                
                HStack(alignment: .center, spacing: 12) {
                        Text("\(card)")
                            .frame(width: carddim[0], height: carddim[1])
                            .padding(12)
                            .background(Color(uiColor: .secondarySystemGroupedBackground))
                            .cornerRadius(8)
                            .shadow(radius: 1, x: 1, y: 1)
                            .font(.system(size: textsize))
                            .draggable(TransferableInt(value: card)){
                                Text("\(card)")
                                    .padding(12)
                                    .background(.thinMaterial)
                                    .cornerRadius(8)
                            }
                        
                    
//                    Spacer()
                }
                .padding(.vertical)
            }
        }
        
        
    }
}
#Preview {
    draggabletestView()
}
