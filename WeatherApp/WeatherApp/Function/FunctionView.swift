//
//  WeeklyWeatherView.swift
//  WeatherApp
//
//  Created by Thanh on 7/3/20.
//  Copyright © 2020 Thanh. All rights reserved.
//

import SwiftUI

struct FunctionView: View {
    //var weather : weeklyWeather?
    
    var value: Int = 0
    var list = listFunc
    var height: CGFloat = 0
    var CurrentTemp: Double = 0
    var NextTemp: Double = 0
    var width = UIScreen.main.bounds.width / 2

    var body: some View {
       
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                NavigationLink(destination: PredictView( CurrentTemp: CurrentTemp, NextTemp: NextTemp))
                    {
                        CardView(list: self.list[0])
                    .frame(width: self.width, height: self.value == 0 ? 0 : self.height * 0.60)
                    .animation(.easeInOut(duration: 0.5))
                    .modifier(CardViewModifier(0)) //-----
                }
                NavigationLink( destination: PredictWithHumid(nextWather: tagData[2])){
                CardView(list: self.list[1])
                .frame(width: self.width, height: self.value == 0 ? 0 : self.height * 0.60)
                .animation(.easeInOut(duration: 0.5))
                .modifier(CardViewModifier(1))     //-----
                }
            }
        }.padding(20)
        .frame(height: self.value == 0 ? 0 : self.height * 0.65).animation(.easeInOut(duration: 0.5))
    }
}

