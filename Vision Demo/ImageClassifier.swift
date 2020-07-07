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

class imageClassifier{
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
       
       /// - Tag: PerformRequests
       func updateClassifications(for image: UIImage){
           
           let orientation = CGImagePropertyOrientation(image.imageOrientation)
           guard let ciImage = CIImage(image: image) else { print("Unable to create \(CIImage.self) from \(image).")
            return
        }
           
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
       
       /// Updates the UI with the results of the classification.
       /// - Tag: ProcessClassifications
       func processClassifications(for request: VNRequest, error: Error?) {
           DispatchQueue.main.async {
               guard let results = request.results else {
//                   self.classificationLabel.text = "Unable to classify image.\n\(error!.localizedDescription)"
                   return
               }
               // The `results` will always be `VNClassificationObservation`s, as specified by the Core ML model in this project.
               let classifications = results as! [VNClassificationObservation]
           
               if classifications.isEmpty {
//                   self.classificationLabel.text = "Nothing recognized."
               } else {
                   // Display top classifications ranked by confidence in the UI.
                   let topClassifications = classifications.prefix(2)
                   let descriptions = topClassifications.map { classification in
                       // Formats the classification for display; e.g. "(0.37) cliff, drop, drop-off".
                      return String(format: "  (%.2f) %@", classification.confidence, classification.identifier)
                   }
//                   self.classificationLabel.text = "Classification:\n" + descriptions.joined(separator: "\n")
                print(descriptions)
               }
           }
       }
       
}
