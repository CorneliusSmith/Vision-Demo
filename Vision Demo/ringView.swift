//
//  ringView.swift
//  
//
//  Created by Cornelius Smith on 2020-07-07.
//

import SwiftUI
import NeumorphismUI

struct ringView: View {
    
    @EnvironmentObject var neumorphism: NeumorphismManager
    @ObservedObject var nutritionInfo: foodInfo
    
    var body: some View {
        HStack{
            ZStack{
                Circle()
                .fill(neumorphism.color)
                .neumorphismConcave(shapeType: .circle, color: nil)
                .frame(width: 200, height: 200)
                
                PercentageRing(
                    ringWidth: 20, percent: self.nutritionInfo.calPercent ,
                    backgroundColor: Color.red.opacity(0.2),
                    foregroundColors: [.pink, .orange]
                )
                .frame(width: 180, height: 180)
                .previewLayout(.sizeThatFits)
                
                PercentageRing(
                    ringWidth: 20, percent: self.nutritionInfo.fatPercent ,
                    backgroundColor: Color.green.opacity(0.2),
                    foregroundColors: [.green, .blue]
                )
                .frame(width: 140, height: 140)
                .previewLayout(.sizeThatFits)
                PercentageRing(
                    ringWidth: 20, percent: self.nutritionInfo.carbPercent ,
                    backgroundColor: Color.yellow.opacity(0.2),
                    foregroundColors: [.yellow, .white]
                )
                .frame(width: 100, height: 100)
                .previewLayout(.sizeThatFits)

            }
            ZStack{
                RoundedRectangle(cornerRadius: 16)
                .fill(neumorphism.color)
                .neumorphismConcave(shapeType: .roundedRectangle(cornerRadius: 16), color: nil)
                .frame(width: 200, height: 200)
                if self.nutritionInfo.showText{
                    VStack(alignment: .leading){
                        Text("Per \(self.nutritionInfo.servingUnit.capitalized)")
                            .foregroundColor(self.neumorphism.fontColor())
                            .font(.system(size: 14,  weight: .semibold))
                            .scaledToFit()
                            .padding(.bottom)
                            
                        
                        Text("Total Calories: \(self.nutritionInfo.calories)/2000\n")
                            //.underline(color: Color.red)
                            .foregroundColor(Color.red)
                            .foregroundColor(self.neumorphism.fontColor())
                            .font(.system(size: 14))
                            .scaledToFit()
                    
                        Text("Total Fat: \(self.nutritionInfo.totalFat)/77g\n")
                            //.underline(color: Color(hex: "538f53"))
                            .foregroundColor(Color(hex: "538f53"))
                            .foregroundColor(self.neumorphism.fontColor())
                            .scaledToFit()
                            .font(.system(size: 14))
                    
                    
                        Text("Total Carbs: \(self.nutritionInfo.totalCarb)/1300g\n")
                            //.underline(color: Color(hex: "d1c238"))
                            .foregroundColor(Color(hex: "9c8c02"))
                            .foregroundColor(self.neumorphism.fontColor())
                            .scaledToFit()
                            .font(.system(size: 14))
                    }
                }
            }
            
        }
    }
}

//struct ringView_Previews: PreviewProvider {
//    static var previews: some View {
//        ringView()
//    }
//}
