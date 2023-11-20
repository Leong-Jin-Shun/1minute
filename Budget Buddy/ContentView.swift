//
//  ContentView.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 18/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var leafVar = LeafVar()
    
    var body: some View {
        ZStack {
            BackgroundView().environmentObject(leafVar)
            
            TitleView()
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Image("Ouch").resizable().scaledToFill()).ignoresSafeArea().onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation(.interpolatingSpring(stiffness: 225, damping: 15)) {
                    leafVar.rotation = 1.0
                }
                
                withAnimation() {
                    leafVar.extrusion = 1.0
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
