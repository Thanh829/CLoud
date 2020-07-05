//
//  PredictViewModel.swift
//  WeatherApp
//
//  Created by Thanh on 7/5/20.
//  Copyright © 2020 Thanh. All rights reserved.
//

import Foundation
import  SwiftUI
import Combine


final class PredictViewModel: ObservableObject{
    @Published var NextTemp: NextWeather?
    var Temp: String
    var Humid: String
    init() {
        self.Humid = ""
        self.Temp = ""
    }
    
}
extension PredictViewModel{
    func fetch(){
        print("send")
        var url : String = ""
        print(self.Humid.isEmpty)
        if self.Humid.isEmpty && !self.Temp.isEmpty
        {
            if(self.Temp.contains("."))
            {
                url = "http://ec2-13-112-143-23.ap-northeast-1.compute.amazonaws.com:5000/iot/\(self.Temp)0"
            }
            else
            {
               url =  "http://ec2-13-112-143-23.ap-northeast-1.compute.amazonaws.com:5000/iot/\(self.Temp).0"
            }
        }
        else if !self.Humid.isEmpty && !self.Temp.isEmpty
        {
            if self.Temp.contains(".") && self.Humid.contains(".")
            {
               url = "http://ec2-13-112-143-23.ap-northeast-1.compute.amazonaws.com:5000/iot/\(self.Temp)0/\(self.Humid)0"
            }
            else if !self.Temp.contains(".") && self.Humid.contains(".")
            {
              url =  "http://ec2-13-112-143-23.ap-northeast-1.compute.amazonaws.com:5000/iot/\(self.Temp).0/\(self.Humid)0"           }
            else if self.Temp.contains(".") && !self.Humid.contains(".")
            {
              url = "http://ec2-13-112-143-23.ap-northeast-1.compute.amazonaws.com:5000/iot/\(self.Temp)0/\(self.Humid).0"
            }
            else
            {
                url =  "http://ec2-13-112-143-23.ap-northeast-1.compute.amazonaws.com:5000/iot/\(self.Temp).0/\(self.Humid).0"
            }
        }
        API().fetchWeather(url: url)
        {
            self.NextTemp = $0
            
        }
    }
}
