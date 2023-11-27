//
//  BrickWallView.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 25/11/23.
//

import SwiftUI

struct BrickWallView: View {
    
    @State var height = 900.0
    
    var body: some View {
        ZStack {
            Image("Brick Wall").renderingMode(.original).resizable().scaledToFill().saturation(0.35).brightness(0.1)
            
            ZStack {
                Image("Sky").resizable().scaledToFit()
                
                Image("Mural 1").rotationEffect(.degrees(30)).offset(x: -100, y: height / -6).shadow(radius: 15)
                
                Image("Mural 2").rotationEffect(.degrees(-10)).offset(x: 100, y: 50).shadow(radius: 15)
                
                Image("Mural 3").offset(x: -75, y: 250).shadow(radius: 15)
                
                Image("Brick Wall").renderingMode(.original).resizable().scaledToFill().saturation(0.35).brightness(0.1).opacity(0.15)
            }.brightness(-0.15).frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea().mask(
                ZStack {
                    Image("Brick Wall Mask").renderingMode(.original).resizable().scaledToFill()
                    
                    Image("Paint Splatter Wall").renderingMode(.original).resizable().scaledToFill().scaleEffect(x: -0.5, y: 0.5).position(x: 600, y: height / 9 * 5)
                    
                    Image("Paint Splatter Wall").renderingMode(.original).resizable().scaledToFill().scaleEffect(x: -0.5, y: 0.5).position(x: 600, y: height / 9 * 7)
                }.mask(
                    ZStack {
                        Image("Paint Splatter Wall").renderingMode(.original).resizable().scaledToFill().scaleEffect(1).position(x: 100, y: height / 9 * 6)
                        
                        Image("Paint Splatter Wall").renderingMode(.original).resizable().scaledToFill().scaleEffect(0.75).position(x: 600, y: height / 9 * 6.75)
                        
                        Image("Paint Splatter Wall").renderingMode(.original).resizable().scaledToFill().scaleEffect(1).position(x: 400, y: height)
                    }
                    )
            )
        }.frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea()
    }
}

struct BrickWallView_Previews: PreviewProvider {
    static var previews: some View {
        BrickWallView(height: 900)
    }
}
