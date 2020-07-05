//
//  WeeklyWeatherViewModel.swift
//  WeatherApp
//
//  Created by Thanh on 7/3/20.
//  Copyright © 2020 Thanh. All rights reserved.
//

import SwiftUI
import Combine

class FunctionViewModel: ObservableObject {
    @Published var function: Function?
    init() {
        self.fetch()
    }
}
extension FunctionViewModel {
    func fetch() {
        self.function?.list = [0,1]
    }
}

