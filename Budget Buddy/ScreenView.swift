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
                Image("Vertical Shorter Pole").resizable().aspectRatio(2, contentMode: .fit).rotationEffect(.degrees(90)).ignoresSafeArea().padding(-25).padding(.top, 17.5)
                
                Spacer()
                
                Image("Vertical Shorter Pole").resizable().aspectRatio(2, contentMode: .fit).rotationEffect(.degrees(90)).ignoresSafeArea().padding(-25).offset(y: -15)
            }.ignoresSafeArea().padding(-45).shadow(radius: 5)
            
            HStack {
                Image("Vertical Shorter Pole").resizable().aspectRatio(2, contentMode: .fit).scaleEffect(1.75).ignoresSafeArea().offset(x: 5, y: 37.5).padding(-25)
                
                Spacer()
                
                Image("Vertical Shorter Pole").resizable().aspectRatio(2, contentMode: .fit).scaleEffect(1.75).ignoresSafeArea().offset(x: -5, y: 37.5).padding(-25)
            }.ignoresSafeArea().padding(-45).shadow(radius: 5)
        }
    }
}

struct ScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenView().frame(width: 75, height: 75)
    }
}
