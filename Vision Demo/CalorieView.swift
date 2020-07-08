//
//  CalorieView.swift
//  Vision Demo
//
//  Created by Cornelius Smith on 2020-07-07.
//  Copyright © 2020 Cornelius Smith. All rights reserved.
//

import SwiftUI

struct CalorieView: View {
    var label: String
    @ObservedObject var nutritionInfo: foodInfo
    var body: some View {
        VStack{
            
            Text(label)
            Text(self.nutritionInfo.calories)
            Text(self.nutritionInfo.servingQty)
            Text(self.nutritionInfo.servingUnit)
            Text(self.nutritionInfo.sugars)
            Text(self.nutritionInfo.protein)
            Text(self.nutritionInfo.totalFat)
            Text(self.nutritionInfo.sodium)
        }
        
    }
    
}

//struct CalorieView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalorieView()
//    }
//}
