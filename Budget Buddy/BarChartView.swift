//
//  BarChartView.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 22/11/23.
//

import SwiftUI

struct BarView: View {
    var datum: Double
    var colors: [Color]
    
    var gradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: colors), startPoint: .top, endPoint: .bottom)
    }
    
    var body: some View {
        Rectangle()
            .fill(gradient)
            .opacity(datum == 0.0 ? 0.0 : 1.0)
    }
}

struct BarChartView: View {
    var data: [Double]
    var colors: [Color]
    var line: Double
    
    var highestData: Double {
        let max = data.max() ?? 1.0
        if max == 0 { return 1.0 }
        return max
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                HStack(alignment: .bottom, spacing: 4.0) {
                    ForEach(data.indices, id: \.self) { index in
                        let width = (geometry.size.width / CGFloat(data.count)) - 4.0
                        let height = geometry.size.height * data[index] / highestData
                        
                        BarView(datum: data[index], colors: colors)
                            .frame(width: width, height: height, alignment: .bottom)
                    }
                }
                
                ZStack {
                    ForEach(data.indices, id: \.self) { index in
                        let width = (geometry.size.width / CGFloat(data.count)) - 4.0
                        let height = geometry.size.height * data[index] / highestData
                        
                        Text("$\(data[index], specifier: "%.2f")").font(.custom("Christmas School", size: 16)).lineLimit(1).fixedSize(horizontal: true, vertical: true).padding(-100).offset(x: -25 + (height / 1.75), y: ((CGFloat(index) + 2.8) * (width + 4.0) - (geometry.size.width / 2)))
                    }
                }.padding(0).rotationEffect(.degrees(-90))
                
                if (line >= 0.0) {
                    ZStack {
                        if (line <= highestData) {
                            Image("Wooden Pole").resizable().scaledToFit().rotationEffect(.degrees(45)).scaleEffect(0.9).position(x: geometry.size.width / 2, y: geometry.size.height - geometry.size.height * (line / highestData)).opacity(0.5)
                            
                            Text("Budget").position(x: geometry.size.width + 30, y: geometry.size.height - geometry.size.height * (line / highestData)).font(.custom("Christmas School", size: 16))
                        } else {
                            Image("Wooden Pole").resizable().scaledToFit().rotationEffect(.degrees(45)).scaleEffect(0.9).position(x: geometry.size.width / 2).opacity(0.5)
                            
                            Text("Budget").position(x: geometry.size.width + 30).font(.custom("Christmas School", size: 16))
                        }
                    }.brightness(-0.35).saturation(0).shadow(radius: 5)
                }
            }
        }
    }
}

struct BarChartViewMinion: View {
  @State private var moveValues: [Double] = BarChartViewMinion.mockData(24, in: 0...300)
  @State private var exerciseValues: [Double] = BarChartViewMinion.mockData(24, in: 0...60)
  @State private var standValues: [Double] = BarChartViewMinion.mockData(24, in: 0...1)

  var body: some View {
    VStack(alignment: .leading) {
      Text("Move").bold()
        .foregroundColor(.red)

        BarChartView(data: moveValues, colors: [.red, .orange], line: 200.0)

      Text("Exercise").bold()
        .foregroundColor(.green)

        BarChartView(data: exerciseValues, colors: [.green, .yellow], line: -10)

      Text("Stand").bold()
        .foregroundColor(.blue)

        BarChartView(data: standValues, colors: [.blue, .purple], line: 0.5)
    }
    .padding()
  }

  static func mockData(_ count: Int, in range: ClosedRange<Double>) -> [Double] {
    (0..<count).map { _ in .random(in: range) }
  }
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartViewMinion()
    }
}
