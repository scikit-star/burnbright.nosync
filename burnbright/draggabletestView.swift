//
//  draggabletestView.swift
//  burnbright
//
//  Created by Aksharaa Ramesh on 5/6/26.
//

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
    @State var topDeck: [Int] = [4, 4, 5, 6]
    @State var firstmainPile: Int = 0
    @State var secondmainPile: Int = 0
    @State var bottomDeck: [Int] = [1, 1, 1, 1, 2, 3, 2, 2, 2, 3, 4, 4]
    
    var body: some View {
        VStack{
            KanbanView(cards: topDeck, kandim:[390.0, 150.0], carddim: [20, 40], textsize: 30)
            Spacer()
            
            HStack {
                Spacer()
                MainPileView(card: firstmainPile, kandim:[150.0, 200.0], carddim: [100.0, 150], textsize: 30)
                    .contentShape(Rectangle())
                    .dropDestination(for: TransferableInt.self) { droppedCards, location in
                        let value = droppedCards.first?.value ?? 0
                        if (firstmainPile - 1) == value{
                            firstmainPile = value
                            //bottomDeck.removeAll(where: { $0 == value })
                            if let index = bottomDeck.firstIndex(of: value) {
                                bottomDeck.remove(at: index)
                            }
                        }else if (firstmainPile + 1) == value{
                            firstmainPile = value
                            if let index = bottomDeck.firstIndex(of: value) {
                                bottomDeck.remove(at: index)
                            }
                        }else{
                        }
                        
                        //
                        
                        return true
                    }
                Spacer()
                MainPileView(card: secondmainPile, kandim:[150, 200], carddim: [100.0, 150], textsize: 30)
                    .contentShape(Rectangle())
                    .dropDestination(for: TransferableInt.self) { droppedCards, location in
                        let value = droppedCards.first?.value ?? 0
                        if (secondmainPile - 1) == value{
                            secondmainPile = value
                            //bottomDeck.removeAll(where: { $0 == value })
                            if let index = bottomDeck.firstIndex(of: value) {
                                bottomDeck.remove(at: index)
                            }
                        }else if (secondmainPile + 1) == value{
                            secondmainPile = value
                            if let index = bottomDeck.firstIndex(of: value) {
                                bottomDeck.remove(at: index)
                            }
                        }else{
                        }
                        
                        //
                        
                        return true
                    }
                Spacer()
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
                ScrollView(.horizontal,showsIndicators: false) {
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
                }
                .frame(width: kandim[0], height: kandim[1])
                .background(Color(.secondarySystemFill))
                .cornerRadius(15)
            }
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
