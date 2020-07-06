//
//  ContentView.swift
//  Vision Demo
//
//  Created by Cornelius Smith on 2020-07-06.
//  Copyright © 2020 Cornelius Smith. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @State private var isShowingPicker = false
    @State private var selectedPhoto = UIImage()
    
    var body: some View {
        VStack{
            Image(uiImage: self.selectedPhoto)
            .resizable()
            .frame(width: 300, height: 300)
            
            Button(action:{
                self.isShowingPicker = true
            }){
                Text("Choose Photo")
            }
        }
        .sheet(isPresented: $isShowingPicker) {
            ImagePicker(source: .photoLibrary, selectedImage: self.$selectedPhoto)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}