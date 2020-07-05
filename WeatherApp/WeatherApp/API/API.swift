//
//  API.swift
//  WeatherApp
//
//  Created by Thanh on 7/3/20.
//  Copyright © 2020 Thanh. All rights reserved.
//



import SwiftUI
import Foundation
class API {
   func fetchCurrrentWeather(completion: @escaping (Weather) -> Void) {
        guard let url = URL(string: "http://ec2-13-112-143-23.ap-northeast-1.compute.amazonaws.com:5000/iot") else { return }
        //guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in

                   // Validation
                   guard let data = data, error == nil else {
                       print("something went wrong")
                       return
                   }

                   // Convert data to models/some object

                   var json: Weather?
                   do {
                       json = try JSONDecoder().decode(Weather.self, from: data)
                    print(json)
                   }
                   catch {
                       print("error: \(error)")
                   }
            DispatchQueue.main.async {
                completion(json!)
            }
           
        })
        .resume()
    
    }
    
    func fetchWeather(url: String, completion: @escaping (NextWeather) -> Void) {
        guard let request = URL(string: url) else { return }
        print (request)
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in

                   // Validation
                   guard let data = data, error == nil else {
                       print("something went wrong")
                       return
                   }

                   // Convert data to models/some object

                   var json: NextWeather?
                   do {
                       json = try JSONDecoder().decode(NextWeather.self, from: data)
                    print(json)
                   }
                   catch {
                       print("error: \(error)")
                   }
            DispatchQueue.main.async {
                completion(json!)
            }
           
        })
        .resume()
    
    }
}


        
        
    

    // weekly weahter func
 

