import SwiftUI

struct ContentView: View {
    
    @State var number: String = "2"
    @State var changeView = false
    var body: some View {
        
        if changeView{
            draggabletestView()
        }else{
            Text("\(number)")
                .frame(width: 150, height: 200)
                .background(.red)
                .cornerRadius(15)
                .font(.system(size:40))
            Button("New Screen"){
                changeView = true
            }
        }
        
            
        
    }
}

#Preview {
    ContentView()
}
