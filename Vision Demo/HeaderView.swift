//
//  HeaderView.swift
//  Vision Demo
//
//  Created by Cornelius Smith on 2020-07-07.
//  Copyright © 2020 Cornelius Smith. All rights reserved.
//

import SwiftUI
import NeumorphismUI

struct HeaderView: View {
    @EnvironmentObject var neumorphism: NeumorphismManager
    @Binding var isDark : Bool
    var label: String
    var foodWidth = UIScreen.main.bounds.width * 0.70
    
    var body: some View {
        HStack{
            ZStack{
                   RoundedRectangle(cornerRadius: 16)
                   .fill(neumorphism.color)
                   .neumorphismConcave(shapeType: .roundedRectangle(cornerRadius: 16), color: nil)
                   .frame(width: foodWidth, height: 100)
                   
                Text(self.label.replacingOccurrences(of: "_", with: " ").capitalized)
                   .foregroundColor(self.neumorphism.fontColor())
                   .font(.title)
                
            }
            NeumorphismBindingButton(isSelected: $isDark,
                                     shapeType: .circle,
                                     normalImage: Image(systemName: "sun.max"),
                                     selectedImage: Image(systemName: "moon"),
                                     width: 75,
                                     height: 75,
                                     imageWidth: 50,
                                     imageHeight: 50
            ){
                                        
                self.neumorphism.changeMode()
                }.onAppear() {
                    self.isDark = self.neumorphism.isDark
                }
        }
    }
}

//struct HeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        HeaderView()
//    }
//}
