//
//  ContentView.swift
//  Vision Demo
//
//  Created by Cornelius Smith on 2020-07-06.
//  Copyright © 2020 Cornelius Smith. All rights reserved.
//

import SwiftUI
import Neumorphic
import NeumorphismUI

struct ContentView: View {
    @State private var isShowingPicker = false
    @State private var selectedPhoto = UIImage()
    @ObservedObject var imgClass = imageClassifier(label: "")
    @EnvironmentObject var neumorphism: NeumorphismManager
    @State private var isDark = false
    var foodWidth = UIScreen.main.bounds.width * 0.70
    
    var body: some View {
            ZStack{
                neumorphism.color.edgesIgnoringSafeArea(.all)
                VStack{
                    HeaderView(isDark: $isDark, label: imgClass.label)
                    
                    
                    Spacer()
                   
                    
            
                    
                    Image(uiImage: self.selectedPhoto)
                    .resizable()
                    .frame(width: 300, height: 300)
                    .scaledToFit()
                
                    
//                    CalorieView(label: imgClass.label, nutritionInfo: imgClass.nutritionInfo)
//                    Button(action:{
//                        self.isShowingPicker = true
//                    }){
//                        Text("Choose Photo")
//                    }
                    NeumorphismButton(
                        shapeType: .roundedRectangle(cornerRadius: 20),
                        normalImage: Image(systemName: "camera"),
                        selectedImage: Image(systemName: "camera.fill"),
                        width: 350,
                        height: 100,
                        imageWidth: 50,
                        imageHeight: 50
                    ){
                        self.isShowingPicker.toggle()
                    }
                }
                .sheet(isPresented: $isShowingPicker) {
                    ImagePicker(source: .photoLibrary, selectedImage: self.$selectedPhoto, imgClass: self.imgClass)
                }
            }
        }
    }
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
