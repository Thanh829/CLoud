//
//  PredictWithHumid.swift
//  WeatherApp
//
//  Created by Thanh on 7/4/20.
//  Copyright © 2020 Thanh. All rights reserved.
//

import SwiftUI

struct PredictWithHumid: View {
    @State var Temp: String = ""
     @State var Humid: String = ""
    @State private var show = false
    @State var nextWather : Tag
    @ObservedObject var NextTemp = PredictViewModel()
    @State var active = false
    @State var status: String = "Ready!"
    @State private var keyboardHeight: CGFloat = 0
    var body: some View {
       
        ZStack {
        Color.black.opacity(active ? 0.5 : 0)
            .animation(.linear)
            .edgesIgnoringSafeArea(.all)
        
        ScrollView {
        
        VStack() {
            Text("Temperature").font(.headline).frame(maxWidth: .infinity, alignment: .leading)
                                   .padding(.leading)
                                   .padding(.top,60)
            TextField("Enter your data", text: self.$Temp)
                .padding()
                .background(Color.init("9FA5AD"))
                .cornerRadius(15)
            Text("Humidity").font(.headline).frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
            .padding(.top, 30)
            TextField("Enter your data", text: self.$Humid)
                .padding()
                .background(Color.init("9FA5AD"))
                .cornerRadius(15)
            Button(action: {
                self.status="Please wait..."
                if self.Temp.isEmpty
                {
                    self.show = true
                }
                else{
                    self.NextTemp.Temp = self.Temp
                    self.NextTemp.Humid = self.Humid
                    print(self.NextTemp.Temp)
                    self.NextTemp.fetch()
                    
                    self.nextWather = Tag(title: "Next ", subtitle: "Help you to predict", image: #imageLiteral(resourceName: "Card2"), logo: #imageLiteral(resourceName: "Logo3"), color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), show: false)
                    self.status = "Complete!!"
                    
                    
                }
                
            }) {
                Text("Get Predict")
                    .padding(10.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(lineWidth: 2.0)
                            
                    )
            }.hoverEffect(.lift).hoverEffect(.highlight).padding().alert(isPresented: self.$show){
                Alert(title: Text("Something wrong!"),message: Text("You didn't import data, please type data" ), dismissButton: .default(Text("OK")))
                
            }
            Text(self.status)
                .foregroundColor(.blue)
                .fontWeight(Font.Weight.thin)
                .font(.system(size: 28))
            GeometryReader { geometry in
                PredictTemp(show: self.$nextWather.show, course: self.nextWather, active: self.$active, NextTemp:  self.NextTemp.NextTemp?.next ?? 0)
                    .offset(y: self.nextWather.show ? -geometry.frame(in: .global).minY : 0)
                
            }
            .frame(height: 280)
            .frame(maxWidth: self.nextWather.show ? .infinity : screen.width - 60)
            .zIndex(self.nextWather.show ? 1 : 0)
            .foregroundColor(.black)
             
            
            }.padding(20)
        
        }
           
        }.edgesIgnoringSafeArea(.all).keyboardType(.numbersAndPunctuation).keyboardAdaptive()
        
        
    }
}
/*
struct PredictWithHumid_Previews: PreviewProvider {
    static var previews: some View {
        PredictWithHumid(Temp: "0")
    }
}
 */
