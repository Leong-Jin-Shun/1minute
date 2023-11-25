//
//  BrickWallView.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 25/11/23.
//

import SwiftUI

struct BrickWallView: View {
    var body: some View {
        ZStack {
            Image("Brick Wall").renderingMode(.original).resizable().scaledToFill().saturation(0.35).brightness(0.2)
            
            ZStack {
                Image("Sky")
            }.brightness(-0.1).opacity(0.85).frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea().mask(
                ZStack {
                    Image("Brick Wall Mask").renderingMode(.original).resizable().scaledToFill()
                    
                    Image("Paint Splatter Wall").renderingMode(.original).resizable().scaledToFill().scaleEffect(x: -0.5, y: 0.5).position(x: 600, y: 500)
                    
                    Image("Paint Splatter Wall").renderingMode(.original).resizable().scaledToFill().scaleEffect(x: -0.5, y: 0.5).position(x: 600, y: 700)
                }.mask(
                    ZStack {
                        Image("Paint Splatter Wall").renderingMode(.original).resizable().scaledToFill().scaleEffect(1).position(x: 100, y: 600)
                        
                        Image("Paint Splatter Wall").renderingMode(.original).resizable().scaledToFill().scaleEffect(0.75).position(x: 600, y: 675)
                        
                        Image("Paint Splatter Wall").renderingMode(.original).resizable().scaledToFill().scaleEffect(1).position(x: 400, y: 900)
                    }
                    )
            )
        }.frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea()
    }
}

struct BrickWallView_Previews: PreviewProvider {
    static var previews: some View {
        BrickWallView()
    }
}
