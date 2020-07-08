//
//  ImagePicker.swift
//  Vision Demo
//
//  Created by Cornelius Smith on 2020-07-06.
//  Copyright © 2020 Cornelius Smith. All rights reserved.
//

import Foundation
import UIKit
import CoreML
import Vision
import SwiftUI


struct ImagePicker:UIViewControllerRepresentable{
    
    @Environment(\.presentationMode) private var presentationMode
    var source: UIImagePickerController.SourceType
    @Binding var selectedImage: UIImage
    @ObservedObject var imgClass:imageClassifier
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
        
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
    
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = false
            imagePicker.sourceType = source
            imagePicker.delegate = context.coordinator
    
            return imagePicker
       }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            parent.selectedImage = image
            parent.presentationMode.wrappedValue.dismiss()
            //queries model to classify food by using observed imageClassifier object passed to the parent imagePickerController
            parent.imgClass.updateClassifications(for: image)
        }
    }
}
