//
//  detailView.swift
//  Vision Demo
//
//  Created by Cornelius Smith on 2020-07-07.
//  Copyright © 2020 Cornelius Smith. All rights reserved.
//

import SwiftUI
import NeumorphismUI
import SwiftUICharts

struct detailView: View {
    @EnvironmentObject var neumorphism: NeumorphismManager
    @ObservedObject var nutritionInfo: foodInfo
    @Binding var chartStyle: ChartStyle

    var body: some View {
        
        VStack{
              
            ZStack{
                RoundedRectangle(cornerRadius: 16)
                .fill(neumorphism.color)
                .neumorphismConcave(shapeType: .roundedRectangle(cornerRadius: 16), color: nil)
                    .frame(width:350, height: 100)
                    .padding(.horizontal)
                    .padding(.bottom)
                    .neumorphismShadow()

                if self.nutritionInfo.showText{
                    VStack(alignment: .leading){
                            Text("Sugar")
                                .font(.title)
                                .foregroundColor(self.neumorphism.fontColor())

                            Text("Amount in \(nutritionInfo.foodName): \(nutritionInfo.sodium)")
                                .foregroundColor(self.neumorphism.fontColor())
                            Text("Recommended Daily Amount: 37.5g")
                                .foregroundColor(self.neumorphism.fontColor())

                        }.padding(.bottom)
                    }
                }

            ZStack{
                RoundedRectangle(cornerRadius: 16)
                .fill(neumorphism.color)
                .neumorphismConcave(shapeType: .roundedRectangle(cornerRadius: 16), color: nil)
                    .frame(width:350, height: 100)
                    .padding(.horizontal)
                    .padding(.bottom)
                    .neumorphismShadow()

                if self.nutritionInfo.showText{
                    VStack(alignment: .leading){
                            Text("Protien")
                                .font(.title)
                                .foregroundColor(self.neumorphism.fontColor())

                            Text("Amount in \(nutritionInfo.foodName): \(nutritionInfo.protein)")
                                .foregroundColor(self.neumorphism.fontColor())
                            Text("Recommended Daily Amount: 56g")
                                .foregroundColor(self.neumorphism.fontColor())

                        }.padding(.bottom)
                }
            }

            ZStack{
                RoundedRectangle(cornerRadius: 16)
                .fill(neumorphism.color)
                .neumorphismConcave(shapeType: .roundedRectangle(cornerRadius: 16), color: nil)
                    .frame(width:350, height: 100)
                    .padding(.horizontal)
                    .padding(.bottom)
                    .neumorphismShadow()

                if self.nutritionInfo.showText{
                    VStack(alignment: .leading){
                            Text("Sodium")
                                .font(.title)
                                .foregroundColor(self.neumorphism.fontColor())

                        Text("Amount in \(nutritionInfo.foodName): \(nutritionInfo.sodium)")
                                .foregroundColor(self.neumorphism.fontColor())
                            Text("Recommended Daily Amount: 2300mg")
                                .foregroundColor(self.neumorphism.fontColor())

                        }.padding(.bottom)
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
