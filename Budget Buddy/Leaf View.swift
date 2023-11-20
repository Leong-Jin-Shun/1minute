//
//  Leaf View.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 18/11/23.
//

import SwiftUI

struct Leaf_View: View {
    
    @State var leafVar = 0.0
    
    var body: some View {
        Text(String(leafVar))
    }
}

struct Leaf_View_Previews: PreviewProvider {
    static var previews: some View {
        Leaf_View()
    }
}
