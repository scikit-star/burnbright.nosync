//
//  draggabletestView.swift
//  burnbright
//
//  Created by Aksharaa Ramesh on 5/6/26.
//

import SwiftUI

struct draggabletestView: View {
    @State var topDeck: Set<String> = []
    @State var mainPile: Set<String> = ["2"]
    @State var bottomDeck: Set<String> = ["1", "2", "3"]
    
    var body: some View {
        VStack{
            KanbanView(cards: topDeck, kandim:[390.0, 150.0], carddim: [20, 40], textsize: 30)
                
            Spacer()
            KanbanView(cards: mainPile, kandim:[300.0, 300.0], carddim: [130, 200], textsize: 30)
            Spacer()
            KanbanView(cards: bottomDeck, kandim:[390.0, 150.0], carddim: [20, 40], textsize: 30)
                .dropDestination(for: String.self) { droppedCards, location in
                    
                    mainPile.formUnion(Set(droppedCards))
                    
                    return true
                } //sth wrong here but idk what, "Adding 'UIView' as a subview of UIHostingController.view is not supported and may result in a broken view hierarchy. Add your view above UIHostingController.view in a common superview or insert it into your SwiftUI content in a UIViewRepresentable instead."
            
        }
    }
}
struct KanbanView: View {
    let cards: Set<String>
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
                    ForEach(cards.sorted(), id: \.self){ card in
                        Text(card)
                            .frame(width: carddim[0], height: carddim[1])
                            .padding(12)
                            .background(Color(uiColor: .secondarySystemGroupedBackground))
                            .cornerRadius(8)
                            .shadow(radius: 1, x: 1, y: 1)
                            .font(.system(size: textsize))
                            .draggable(card)
                        
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
