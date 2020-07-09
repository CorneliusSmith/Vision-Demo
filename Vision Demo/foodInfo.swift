//
//  foodInfo.swift
//  Vision Demo
//
//  Created by Cornelius Smith on 2020-07-07.
//  Copyright © 2020 Cornelius Smith. All rights reserved.
//

import Foundation
import SwiftUI

class foodInfo: ObservableObject {
    @Published var foodName: String
    @Published var servingQty: String
    @Published var servingUnit: String
    @Published var calories: String
    @Published var sugars: String
    @Published var sodium: String
    @Published var protein: String
    @Published var totalFat: String
    @Published var totalCarb: String
    @Published var calPercent = 0.0
    @Published var carbPercent = 0.0
    @Published var fatPercent = 0.0
    @Published var showText: Bool = false
    @Published var sodiumGraph = 0.0
    @Published var sugarGraph = 0.0
    @Published var proteinGraph = 0.0

    
    init(foodName:String, servingQty: String, servingUnit: String, calories: String, sugars: String, protein: String, totalFat: String, sodium: String, totalCarb: String) {
        self.foodName = foodName
        self.servingQty = servingQty
        self.servingUnit = servingUnit
        self.calories = calories
        self.sugars = sugars
        self.protein = protein
        self.totalFat = totalFat
        self.sodium = sodium
        self.totalCarb = totalCarb
    }
    

    //Makes a post request to the nutritionix api to get nutritional information about classified food
    func getCalories(label:String){
        let url = URL(string: "https://trackapi.nutritionix.com/v2/natural/nutrients")! // force unwraps url because we know its a valid unchanging string as an input
        let parameters = ["query":label,
        "timezone": "US/Eastern"]
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("a0955bb7", forHTTPHeaderField: "x-app-id")
        request.setValue("706d550fc919dc40a0e928f0b76de5b4", forHTTPHeaderField: "x-app-key")
        request.httpMethod = "POST"
        request.setValue("0", forHTTPHeaderField: "x-remote-user-id")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch let error {
            print(error.localizedDescription)
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil || data == nil {
                print("Client error!")
                return
            }

            if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode){} else{
                print("Server Error")
                return
            }

            guard let mime = response?.mimeType, mime == "application/json" else {
                print("Wrong MIME type")
                return //we dont have to worry about wrong MIME type with Nutritionix API but error checking to be safe
            }

            do {
                //unwraps data and makes it a dictionary object
                if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]{
                    //takes the defined dictionary and turns it into an array containing the nested dictionary of calorie information
                    let dictionary = json["foods"] as! [[String: Any]]
                    print(dictionary[0]["food_name"]!)
                    print(dictionary[0]["serving_qty"]!)
                    print(dictionary[0]["serving_unit"]!)
                    print(dictionary[0]["nf_calories"]!)
                    print(dictionary[0]["nf_sugars"]!)
                    print(dictionary[0]["nf_protein"]!)
                    print(dictionary[0]["nf_total_fat"]!)
                    //cant make changes on seperate thred so opened a dispatch queue to publish changes.
                    DispatchQueue.main.async {
                        //casting numerical values to strings
                        self.foodName = dictionary[0]["food_name"] as! String
                        self.calories = String(dictionary[0]["nf_calories"]! as? Double ?? 0.0)
                        self.servingUnit = dictionary[0]["serving_unit"] as! String
                        self.servingQty = String(dictionary[0]["serving_qty"]! as? Int ?? 0)
                        self.sugars = String(dictionary[0]["nf_sugars"]! as? Double ?? 0.0)
                        self.protein = String(dictionary[0]["nf_protein"]! as? Double ?? 0.0)
                        self.totalFat = String(dictionary[0]["nf_total_fat"]! as? Double ?? 0.0)
                        self.totalCarb = String(dictionary[0]["nf_total_carbohydrate"]! as? Double ?? 0.0)
                        
                        //calculated the percent for the ring view. To avoid divide by 0 error the default val is 0.1
                        self.sodium = String(dictionary[0]["nf_sodium"]! as? Double ?? 0.0)
                        self.calPercent = (Double((dictionary[0]["nf_calories"]! as? Double ?? 0.1)) / Double(2000)) * 100
                        self.carbPercent = (Double((dictionary[0]["nf_total_carbohydrate"]! as? Double ?? 0.1)) / Double(1300)) * 100
                        self.fatPercent = (Double((dictionary[0]["nf_total_fat"]! as? Double ?? 0.1)) / Double(77)) * 100
                        print(dictionary[0]["nf_calories"]! as? Double ?? 0.1 / Double(2000))
                        print("\n\n\n", self.calPercent, self.carbPercent, self.fatPercent, Double((dictionary[0]["nf_calories"]! as? Double ?? 0.1)) / Double(2000))
                        self.sodiumGraph = dictionary[0]["nf_sodium"]! as? Double ?? 0.0
                        self.sugarGraph = dictionary[0]["nf_sugars"]! as? Double ?? 0.0
                        self.proteinGraph = dictionary[0]["nf_protein"]! as? Double ?? 0.0
                        self.showText = true
                    }
                    
                    
                }

            } catch{
                print("JSON error: \(error.localizedDescription)")
            }

        }
        task.resume()
    }
}
