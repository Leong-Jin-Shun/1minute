//
//  BackgroundView.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 19/11/23.
//

import SwiftUI

class LeafVar: ObservableObject {
    @Published var rotation = -1.0
}

struct BackgroundView: View {
    
    @EnvironmentObject var leafVar: LeafVar
    
    var body: some View {
        ZStack {
//            ZStack {
//                Image("Mountains").scaleEffect(2).offset(y: 50).brightness(0.25)
//
//                Rectangle().fill(LinearGradient(colors: [Color(.black).opacity(0), .white], startPoint: .top, endPoint: .bottom)).frame(width: 400, height: 200).offset(y: 125)
//
//                Image("Jungle Trees").scaleEffect(2).offset(y: 225).brightness(-0.15)
//
//                Rectangle().fill(LinearGradient(colors: [Color(.black).opacity(0), Color(.black).opacity(0.75)], startPoint: .top, endPoint: .bottom)).frame(width: 400, height: 300).offset(y: 300)
//            }.frame(width: 385)
            
            Image("Chalkboard Texture").resizable().scaledToFit().position(x: 200, y: CGFloat(-100.0 + 100.0 * leafVar.rotation))
            
            ZStack {
                Image("Wooden Pole").rotationEffect(.degrees(45)).position(x: 200, y: CGFloat(10.0 + 20.0 * leafVar.rotation)).scaleEffect(1.0)
                
                Image("Wooden Pole").rotationEffect(.degrees(45)).position(x: 200, y: CGFloat(75.0 + 100.0 * leafVar.rotation)).scaleEffect(1.0)
                
                Image("Wooden Pole").rotationEffect(.degrees(45)).position(x: 200, y: CGFloat(845.0 - 20.0 * leafVar.rotation)).scaleEffect(1.0)
                
                Image("Wooden Pole").rotationEffect(.degrees(-45)).position(x: CGFloat(-5.5 + 10.0 * leafVar.rotation), y: 200).scaleEffect(1.0)
                
                Image("Wooden Pole").rotationEffect(.degrees(-45)).position(x: CGFloat(397.5 - 10.0 * leafVar.rotation), y: 200).scaleEffect(1.0)
                
                Image("Wooden Pole").rotationEffect(.degrees(-44.5)).position(x: CGFloat(-5.5 + 10.0 * leafVar.rotation), y: 600).scaleEffect(1.0)
                
                Image("Wooden Pole").rotationEffect(.degrees(-44.5)).position(x: CGFloat(397.5 - 10.0 * leafVar.rotation), y: 600).scaleEffect(1.0)
            }.brightness(-0.35).saturation(0)
            
            ZStack {
                //LeafView().environmentObject(leafVar).rotationEffect(.degrees(90)).position(x: 0, y: 0).scaleEffect(0.3, anchor: .topLeading)
                
                //LeafView().environmentObject(leafVar).rotationEffect(.degrees(180)).position(x: 1300, y: 0).scaleEffect(0.3, anchor: .topLeading)
                
                LeafView().environmentObject(leafVar).rotationEffect(.degrees(-90)).position(x: 1300, y: 2800).scaleEffect(0.3, anchor: .topLeading)
                
                //LeafView().environmentObject(leafVar).position(x: 0, y: 2800).scaleEffect(0.3, anchor: .topLeading)
            }
            
            Image("Fairy Lights").resizable().scaledToFit().scaleEffect(1.25).position(x: 200, y: -450.0 + 500.0 * leafVar.rotation)
            
            Image("Fairy Lights").resizable().scaledToFit().scaleEffect(x: -1.25, y: 1.25).position(x: 200, y: -85.0 + 250.0 * leafVar.rotation)
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
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundViewMinion()
    }
}
