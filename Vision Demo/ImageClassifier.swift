//
//  ImageClassifier.swift
//  Vision Demo
//
//  Created by Cornelius Smith on 2020-07-06.
//  Copyright © 2020 Cornelius Smith. All rights reserved.
//

import Foundation
import UIKit
import Vision
import CoreML
import SwiftUI

class imageClassifier: ObservableObject{
    @Published var label: String
    var calories:CalorieView
    init(label: String) {
        self.label = label
        self.calories = CalorieView(label: label)
    }
    
    lazy var classificationRequest: VNCoreMLRequest = {
           do {
               /*
                Use the Swift class `MobileNet` Core ML generates from the model.
                To use a different Core ML classifier model, add it to the project
                and replace `MobileNet` with that model's generated Swift class.
                */
               let model = try VNCoreMLModel(for: SeeFood().model)
               
               let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                   self?.processClassifications(for: request, error: error)
               })
               request.imageCropAndScaleOption = .centerCrop
               return request
           } catch {
               fatalError("Failed to load Vision ML model: \(error)")
           }
       }()
       
       func updateClassifications(for image: UIImage){
           let orientation = CGImagePropertyOrientation(image.imageOrientation)
           guard let ciImage = CIImage(image: image) else { print("Unable to create \(CIImage.self) from \(image).")
            return
        }
           self.label = "Classifying Image..."
           DispatchQueue.global(qos: .userInitiated).async {
               let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
               do {
                   try handler.perform([self.classificationRequest])
               } catch {
                   /*
                    This handler catches general image processing errors. The `classificationRequest`'s
                    completion handler `processClassifications(_:error:)` catches errors specific
                    to processing that request.
                    */
                   print("Failed to perform classification.\n\(error.localizedDescription)")
               }
           }
       }
       
       func processClassifications(for request: VNRequest, error: Error?) {
           DispatchQueue.main.async {
               guard let results = request.results else {
                   print("No Classification Available")
                   return
               }
               // The `results` will always be `VNClassificationObservation`s, as specified by the Core ML model in this project.
               let classifications = results as! [VNClassificationObservation]
           
               if classifications.isEmpty {
                    print("No Classification Available")
               } else {
                   //Gets the top classification
                   let topClassifications = classifications.prefix(1)
                   let descriptions = topClassifications.map { classification in
                       // Formats the classification for display; e.g. "(0.37) cliff, drop, drop-off".
                      return [classification.confidence, classification.identifier]
                   }
                self.label = descriptions[0][1] as? String ?? "Couldn't Classify Image"
                self.calories.getCalories(label: self.label)
//                print (self.label, descriptions[0][1] as! String)
               }
           }
       }
       
}
