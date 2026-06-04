//
//  ContentView.swift
//  burnbright
//
//  Created by Aksharaa Ramesh on 31/3/26.
//

import SwiftUI

enum Quote: CaseIterable{
    case toxic, girlpower, belief, impulse, resilience
}

struct ContentView: View {
    var myquote = Quote.resilience /*Quote.allCases.randomElement()!*/
    @State var myowntime = 61200
    var body: some View {
        TabView {
            Tab("Add new", systemImage: "flame.fill"){
                switch myquote {
                case .toxic:
                    
                    HStack {
                        Spacer()
                        VStack {
                            Text("Tu veux être sur le podium,")
                            Text("Tu n'as pas le droit aux mauvais jours")
                        }
                        Spacer()
                    }
                    .foregroundStyle(.red)
                case .girlpower:
                    HStack {
                        Spacer()
                        Text("Il n'est jamais mieux que moi")
                        Spacer()
                    }
                    .foregroundStyle(.red)
                case .belief:
                    HStack {
                        Spacer()
                        Text("La douleur fait de moi une croyante")
                        Spacer()
                    }
                    .foregroundStyle(.red)
                case .impulse:
                    HStack {
                        Spacer()
                        Text("M'investir et tenter ma chance")
                        Spacer()
                    }
                    .foregroundStyle(.red)
                case .resilience:
                    HStack {
                        Spacer()
                        VStack {
                            Text("Le monde brise tout le monde,et ensuite, beaucoup sont plus forts où ils ont été brisés")
                        }
                        
                        Spacer()
                    }
                    .foregroundStyle(LinearGradient(
                        colors: [.blue, .pink], startPoint: .topTrailing, endPoint: .bottomTrailing))
                }
                }
            Tab("SJPO",systemImage: "soccerball"){
                TimerView(mytime: $myowntime)
            }
                
                        
            }
        }
    }

#Preview {
    ContentView()
}
