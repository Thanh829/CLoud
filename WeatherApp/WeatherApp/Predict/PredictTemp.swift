//
//  PredictTemp.swift
//  WeatherApp
//
//  Created by Thanh on 7/4/20.
//  Copyright © 2020 Thanh. All rights reserved.
//

import Foundation
import SwiftUI


struct PredictView: View {
   @State var tag = tagData
   @State var active = false
    var CurrentTemp : Double
    var NextTemp : Double
   var body: some View {
       
       ZStack {
           Color.black.opacity(active ? 0.5 : 0)
               .animation(.linear)
               .edgesIgnoringSafeArea(.all)
           
           ScrollView {
               VStack(spacing: 30) {
                
                Text("Current: \(String(format: "%.1f", self.CurrentTemp))º")
                       .font(.largeTitle).bold()
                       .frame(maxWidth: .infinity, alignment: .leading)
                       .padding(.leading, 30)
                       .padding(.top, 100)
                       .blur(radius: active ? 20 : 0)
                   
                   
                       GeometryReader { geometry in
                        PredictTemp(show: self.$tag[1].show, course: self.tag[1], active: self.$active, NextTemp:  self.NextTemp)
                               .offset(y: self.tag[1].show ? -geometry.frame(in: .global).minY : 0)
                       }
                       .frame(height: 280)
                       .frame(maxWidth: self.tag[1].show ? .infinity : screen.width - 60)
                       .zIndex(self.tag[1].show ? 1 : 0)
                       .foregroundColor(.black)
                   
                   
               }
                   
               }
               .frame(width: screen.width)
               .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
       }.background(Color.init(hex: "13BDFC"))
           .statusBar(hidden: active ? true : false)
           .animation(.linear)
       .foregroundColor(.black)
        .edgesIgnoringSafeArea(.all)
       
    }
}
struct PredictTemp: View {
     @Binding var show: Bool
       var course: Tag
    
       
    @Binding var active: Bool
     var NextTemp : Double
     
       var body: some View {
           ZStack(alignment: .top) {
               
               
               VStack {
                   HStack(alignment: .top) {
                       VStack(alignment: .leading, spacing: 8.0) {
                           Text(course.title)
                               .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color(course.color))
                         
                       
                       }
                       Spacer()
                       ZStack {
                           
                           VStack {
                               Image(systemName: "xmark")
                                   .font(.system(size: 16, weight: .medium))
                                   .foregroundColor(.white)
                           }
                           .frame(width: 36, height: 36)
                           .background(Color.black)
                           .clipShape(Circle())
                           .opacity(show ? 1 : 0)
                       }
                   }
                   Spacer()
                Text("\(String(format: "%.1f", self.NextTemp))º")
                .font(.system(size: 70, weight: .bold))
                .foregroundColor(.black)
                   Image(uiImage: course.image)
                       .resizable()
                       .aspectRatio(contentMode: .fit)
                       .frame(maxWidth: .infinity)
                       .frame(height: 70, alignment: .top)
               }
               .padding(show ? 30 : 20)
               .padding(.top, show ? 30 : 0)
       //        .frame(width: show ? screen.width : screen.width - 60, height: show ? screen.height : 280)
               .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 460 : 280)
                .background(Color(course.color))
               .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color(course.color).opacity(0.6), radius: 20, x: 0, y: 20)
               
               .onTapGesture {
                   self.show.toggle()
                   self.active.toggle()
               }
           }
           .frame(height: show ?  screen.height: 280)
           .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
           .edgesIgnoringSafeArea(.all)
       }
}

struct PredictTemp_Previews: PreviewProvider {
    static var previews: some View {
        PredictView(CurrentTemp: 0 , NextTemp: 0)
    }
}

