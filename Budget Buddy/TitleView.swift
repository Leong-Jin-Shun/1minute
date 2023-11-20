//
//  TitleView.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 18/11/23.
//

import SwiftUI

struct TitleView: View {
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("BUDGET").italic().fontWeight(.semibold).font(.system(size: 24)).offset(y: 10)
                    
                    Text("BUDDY").italic()
                        .fontWeight(.black).foregroundColor(Color(red: 0.235, green: 0.416, blue: 0.016)).shadow(color: .black, radius: 0, x: 5, y: 5).font(.system(size: 48))
                }.offset(y: 10)
                
                Rectangle().frame(width: 290, height: 2.5).offset(y: -20)
                
                Text("Your Best Friend When Dealing With Money!").italic().fontWeight(.light).font(.system(size: 14)).offset(y: 10).offset(y: -30)
            }
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
