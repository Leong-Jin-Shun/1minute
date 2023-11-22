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
    
    var highestData: Double {
        let max = data.max() ?? 1.0
        if max == 0 { return 1.0 }
        return max
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .bottom, spacing: 4.0) {
                ForEach(data.indices, id: \.self) { index in
                    let width = (geometry.size.width / CGFloat(data.count)) - 4.0
                    let height = geometry.size.height * data[index] / highestData
                    
                    ZStack {
                        BarView(datum: data[index], colors: colors)
                            .frame(width: width, height: height, alignment: .bottom)
                        
                        Text("$\(data[index], specifier: "%.2f")").font(.custom("Christmas School", size: 16)).lineLimit(1).rotationEffect(.degrees(-90)).fixedSize(horizontal: true, vertical: false).padding(-100).offset(x: 75, y: 75)
                    }
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

      BarChartView(data: moveValues, colors: [.red, .orange])

      Text("Exercise").bold()
        .foregroundColor(.green)

      BarChartView(data: exerciseValues, colors: [.green, .yellow])

      Text("Stand").bold()
        .foregroundColor(.blue)

      BarChartView(data: standValues, colors: [.blue, .purple])
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
