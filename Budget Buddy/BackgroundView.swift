//
//  BackgroundView.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 19/11/23.
//

import SwiftUI

class LeafVar: ObservableObject {
    @Published var rotation = -0.5
    @Published var extrusion = -1.0
}

struct BackgroundView: View {
    
    @EnvironmentObject var leafVar: LeafVar
    
    var body: some View {
        ZStack {
            Image("Wooden Pole").rotationEffect(.degrees(45)).position(x: 200, y: 10 + 20 * leafVar.extrusion).scaleEffect(1.0)
            
            Image("Wooden Pole").rotationEffect(.degrees(45)).position(x: 200, y: 845 - 20 * leafVar.extrusion).scaleEffect(1.0)
            
            Image("Wooden Pole").rotationEffect(.degrees(-45)).position(x: -5.5 + 10 * leafVar.extrusion, y: 200).scaleEffect(1.0)
            
            Image("Wooden Pole").rotationEffect(.degrees(-45)).position(x: 395.5 - 10 * leafVar.extrusion, y: 200).scaleEffect(1.0)
            
            Image("Wooden Pole").rotationEffect(.degrees(-44.5)).position(x: -5.5 + 10 * leafVar.extrusion, y: 600).scaleEffect(1.0)
            
            Image("Wooden Pole").rotationEffect(.degrees(-44.5)).position(x: 395.5 - 10 * leafVar.extrusion, y: 600).scaleEffect(1.0)
            
            LeafView().environmentObject(leafVar).rotationEffect(.degrees(90)).position(x: 0, y: 0).scaleEffect(0.3, anchor: .topLeading)
            
            LeafView().environmentObject(leafVar).rotationEffect(.degrees(180)).position(x: 1300, y: 0).scaleEffect(0.3, anchor: .topLeading)
            
            LeafView().environmentObject(leafVar).rotationEffect(.degrees(-90)).position(x: 1300, y: 2800).scaleEffect(0.3, anchor: .topLeading)
            
            LeafView().environmentObject(leafVar).position(x: 0, y: 2800).scaleEffect(0.3, anchor: .topLeading)
        }
    }
}

struct BackgroundViewMinion: View {
    
    @StateObject var leafVar = LeafVar()
    
    var body: some View {
        ZStack {
            BackgroundView().environmentObject(leafVar)
        }.frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea().onAppear() {
            withAnimation(.interpolatingSpring(stiffness: 225, damping: 15)) {
                leafVar.rotation = 1.0
            }
            
            withAnimation() {
                leafVar.extrusion = 1.0
            }
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundViewMinion()
    }
}
