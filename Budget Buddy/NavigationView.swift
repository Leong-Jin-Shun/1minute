//
//  NavigationView.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 20/11/23.
//

import SwiftUI

struct NavigationView: View {
    var body: some View {
        HStack {
            ScreenView().frame(width: 75, height: 75).padding()
            
            ScreenView().frame(width: 75, height: 75).padding()
            
            ScreenView().frame(width: 75, height: 75).padding()
        }
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView()
    }
}
