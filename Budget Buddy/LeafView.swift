//
//  LeafView.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 18/11/23.
//

import SwiftUI

struct LeafView: View {
    
    @EnvironmentObject var leafVar: LeafVar
    
    var body: some View {
        ZStack {
            Image("Leaf 1").resizable().rotationEffect(.degrees(leafVar.rotation * 25), anchor: .bottomLeading)
            
            Image("Leaf 2").resizable().rotationEffect(.degrees(leafVar.rotation * 45), anchor: .bottomLeading)
            
            Image("Leaf 3").resizable().rotationEffect(.degrees(leafVar.rotation * 65), anchor: .bottomLeading).offset(x: 100)
        }.offset(x: -100, y: -400)
    }
}

struct LeafView_Previews: PreviewProvider {
    static var previews: some View {
        LeafView()
    }
}
