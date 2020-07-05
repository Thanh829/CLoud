//
//  Extension.swift
//  WeatherApp
//
//  Created by Thanh on 7/3/20.
//  Copyright © 2020 Thanh. All rights reserved.
//

import SwiftUI



extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        guard var component = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            fatalError()
        }
        component.queryItems = queries.map { URLQueryItem(name: $0.key, value: $0.value)}
        return component.url
    }
}





extension Color{
    init(hex: String){
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }
    static var monday: [Color]{
        return [Color.init(hex: "96ceb4"), Color.init(hex: "96ceb5")]
    }
    static var tueday: [Color]{
        return [Color.init(hex: "ffeead"), Color.init(hex: "ffeead")]
    }
    static var wesday: [Color]{
        return [Color.init(hex: "ff6f69"), Color.init(hex: "ff6f69")]
    }
    static var thusday: [Color]{
        return [Color.init(hex: "ffcc5c"), Color.init(hex: "ffcc5c")]
    }
    static var friday: [Color]{
        return [Color.init(hex: "2193b0"), Color.init(hex: "6dd5ed")]
    }
    
}
func gradientColorOfTheDay(_ day: Int) -> [Color] {
    switch day {
    case 0:
        return Color.monday
    case 1:
        return Color.friday
    default:
        return Color.monday
    }
}

