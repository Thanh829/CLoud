//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Thanh on 7/3/20.
//  Copyright © 2020 Thanh. All rights reserved.
//

import SwiftUI

struct CurrentWeather: View  {
    var weather: Weather?
    var height: CGFloat = 0
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            //Text("Today in \(weather?.name ?? "Nhà Thạnh")")
            Text("Today in Thu Duc")
            .font(.title)
            .foregroundColor(.white)
    
            HStack{
                Text("\(Int(weather?.current ?? 0))º")
                    .foregroundColor(.white)
                    .fontWeight(Font.Weight.medium)
                    .font(.system(size: 65))
                if Int(weather?.current ?? 0) < 28
                {
                Image("rain")
                .resizable()
                .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fit)
                   
                }
                else if Int(weather?.current ?? 0) < 29 && Int(weather?.current ?? 0) >= 28
                {
                    Image("cloud")
                                   .resizable()
                                   .frame(width: 100, height: 100)
                                       .aspectRatio(contentMode: .fit)
                    
                }
                else {
                    Image("clear")
                    .resizable()
                    .frame(width: 100, height: 100)
                        .aspectRatio(contentMode: .fit)
                    
                }
                Text("\(Int(weather?.current_humid ?? 0)) %")
                .foregroundColor(.white)
                    .fontWeight(Font.Weight.thin)
                    .font(.system(size: 28))
            }
            if Int(weather?.current ?? 0) < 28
            {
            Text("Rain")
            .foregroundColor(.white)
            .font(.body)
               
            }
            else if Int(weather?.current ?? 0) < 29 && Int(weather?.current ?? 0) >= 28
            {
                Text("Cloud")
                .foregroundColor(.white)
                .font(.body)
                
            }
            else {
                
                Text("Clear")
                .foregroundColor(.white)
                .font(.body)
            }
            
            
        
            
            
        }.frame(width: height, height: height)
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)).cornerRadius(20)
    }
}
