//
//  CardView.swift
//  WeatherApp
//
//  Created by Thanh on 7/3/20.
//  Copyright © 2020 Thanh. All rights reserved.
//

import SwiftUI

struct CardView: View {
    var list: listData

    var body: some View {
        VStack{
            Text(list.funcName)
                 .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
            Image(uiImage: list.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
            .frame(height: 70, alignment: .top)
            
        }
    }
}

struct CardViewModifier: ViewModifier {
    var index: Int
    
    init(_ index: Int) {
        self.index = index
    }

    func body(content: Content) -> some View {
        content
            .background(LinearGradient(gradient: Gradient(colors: gradientColorOfTheDay(self.index)), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(20)
            
    }

   
}
struct listData{
    var funcName: String
    var image: UIImage
}

var listFunc = [
    listData(funcName: "From Current", image: #imageLiteral(resourceName: "Card1") ) ,
    listData(funcName: "Type Your Data", image: #imageLiteral(resourceName: "Card2"))
    
]
