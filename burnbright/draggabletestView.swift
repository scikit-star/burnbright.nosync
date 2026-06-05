//
//  draggabletestView.swift
//  burnbright
//
//  Created by Aksharaa Ramesh on 5/6/26.
//

import SwiftUI

struct draggabletestView: View {
    @State var topDeck: [String] = ["1", "2", "3", "4", "5", "6"]
    @State var mainPile: [String] = []
    @State var bottomDeck: [String] = []
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
struct KanbanView: View {
    let title: String
    let tasks: [String]
    
    var body: some View {
        VStack (alignment: .leading){
            Text(title).font(.footnote.bold())
            
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color(.secondarySystemFill))
                
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(tasks, id: \.self){ task in
                        Text(task)
                            .padding(12)
                            .background(Color(uiColor: .secondarySystemGroupedBackground))
                            .cornerRadius(8)
                            .shadow(radius: 1, x: 1, y: 1)
                        
                    }
                    Spacer()
                }
                .padding(.vertical)
            }
        }
        
    }
}
#Preview {
    draggabletestView()
}
