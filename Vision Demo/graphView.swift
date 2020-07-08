//
//  graphView.swift
//  Vision Demo
//
//  Created by Cornelius Smith on 2020-07-07.
//  Copyright © 2020 Cornelius Smith. All rights reserved.


import SwiftUI
import NeumorphismUI
import SwiftUICharts

struct graphView: View {
    @EnvironmentObject var neumorphism: NeumorphismManager
    @ObservedObject var nutritionInfo: foodInfo
    @Binding var chartStyle: ChartStyle

    var body: some View {
        
        VStack{
            ZStack{
                    RoundedRectangle(cornerRadius: 16)
                        .fill(neumorphism.color)
                        .neumorphismConcave(shapeType: .roundedRectangle(cornerRadius: 16), color: nil)
                        .padding(.horizontal)
                        .padding(.bottom)
                    if self.nutritionInfo.showText{
                        BarChartView(data: ChartData(values: [("Sodium/\(self.nutritionInfo.servingUnit.capitalized)",self.nutritionInfo.sodiumGraph/1000),
                            ("Sodium/Day",2.3),
                            ("Sugar/\(self.nutritionInfo.servingUnit.capitalized)",self.nutritionInfo.sugarGraph),
                            ("Sugar/Day",37.5),
                            ("Protein/\(self.nutritionInfo.servingUnit.capitalized)",self.nutritionInfo.proteinGraph), ("Sugar/Day",37.5),
                            ("Protein/Day",56)]),
                            title: "Actual Vs Recommended (grams)", style: self.chartStyle, form: CGSize(width: 350, height: 400)) // legend is optional
                }
            }
        }
    }
}

//struct detailView_Previews: PreviewProvider {
//    static var previews: some View {
//        detailView()
//    }
//}
