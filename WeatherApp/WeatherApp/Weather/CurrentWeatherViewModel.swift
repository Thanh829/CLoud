//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Thanh on 7/3/20.
//  Copyright © 2020 Thanh. All rights reserved.
//

import Foundation
import  SwiftUI
import Combine

final class CurrentWeatherViewModel: ObservableObject{
    @Published var current: Weather?
    init() {
        self.fetch()
    }
    
    
}
extension CurrentWeatherViewModel{
    func fetch()  {
        API().fetchCurrrentWeather()
        {
            self.current = $0
        }
    }
}
