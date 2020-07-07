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
    var body: some View {
        Text(label)
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
//            request.setValue("0", forHTTPHeaderField: "x-remote-user-id")
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
                        // handle json

                        print("\n\n")
                }

            } catch{
                print("JSON error: \(error.localizedDescription)")
            }

        }
        task.resume()
    }
}

//struct CalorieView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalorieView()
//    }
//}
