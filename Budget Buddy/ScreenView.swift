//
//  ScreenView.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 20/11/23.
//

import SwiftUI

struct ScreenView: View {
    var body: some View {
        ZStack {
            Rectangle().fill(Color(red: 0.439, green: 0.314, blue: 0.180))
            
            VStack {
                Image("Vertical Shorter Pole").resizable().aspectRatio(2, contentMode: .fit).rotationEffect(.degrees(90)).ignoresSafeArea().padding(-15).padding(.top, 20)
                
                Spacer()
                
                Image("Vertical Shorter Pole").resizable().aspectRatio(2, contentMode: .fit).rotationEffect(.degrees(90)).ignoresSafeArea().padding(-5).offset(y: -10)
            }.ignoresSafeArea().padding(-45).shadow(radius: 5)
            
            HStack {
                Image("Vertical Shorter Pole").resizable().aspectRatio(2, contentMode: .fit).scaleEffect(1.35).ignoresSafeArea().offset(x: 10, y: 40).padding(-25)
                
                Spacer()
                
                Image("Vertical Shorter Pole").resizable().aspectRatio(2, contentMode: .fit).scaleEffect(1.35).ignoresSafeArea().offset(x: -10, y: 40).padding(-25)
            }.ignoresSafeArea().padding(-45).shadow(radius: 5)
        }
    }
}

struct ScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenView().frame(width: 50, height: 50)
    }
}
