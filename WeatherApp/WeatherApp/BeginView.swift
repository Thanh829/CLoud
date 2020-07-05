//
//  BeginView.swift
//  WeatherApp
//
//  Created by Thanh on 7/4/20.
//  Copyright © 2020 Thanh. All rights reserved.
//
import SwiftUI

struct BeginView: View {
    @State var tags = tagData
    @State var active = false
    
    var body: some View {
        NavigationView{
        ZStack {
            Color.black.opacity(active ? 0.5 : 0)
                .animation(.linear)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 30) {
                    Text("Let Begin")
                        .font(.largeTitle).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 30)
                        .padding(.top, 70)
                        .blur(radius: active ? 20 : 0)
                    
                    
                        GeometryReader { geometry in
                            tagView(show: self.$tags[0].show, tag: self.tags[0], active: self.$active)
                                .offset(y: self.tags[0].show ? -geometry.frame(in: .global).minY : 0)
                        }
                        .frame(height: 280)
                        .frame(maxWidth: self.tags[0].show ? .infinity : screen.width - 60)
                        .zIndex(self.tags[0].show ? 1 : 0)
                    
                    NavigationLink (destination: ContentView())
                    {
                       Spacer().fixedSize() 
                    Text("Start")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .frame(width: 200, height: 60)
                            
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .shadow(color: Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 20, x: 20, y: 20)
                        .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 20, x: -20, y: -20)
                    }
                   
                }
                    
                }
                .frame(width: screen.width)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            }
            .statusBar(hidden: active ? true : false)
            .animation(.linear)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
                               .background(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)))
                               .edgesIgnoringSafeArea(.all)
        }
    }
}
let screen = UIScreen.main.bounds
struct tagView: View {
    @Binding var show: Bool
    var tag: Tag
    @Binding var active: Bool
  
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 30.0) {
                Text("Take me to predict the next temperature from the current temperature and humidity or type temperature if you want.")
                
                
            }
            .padding(30)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 280, alignment: .top)
            .offset(y: show ? 460 : 0)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .opacity(show ? 1 : 0)
            
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text(tag.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        Text(tag.subtitle)
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    Spacer()
                    ZStack {
                        Image(uiImage: tag.logo)
                            .opacity(show ? 0 : 1)
                        
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
                Image(uiImage: tag.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140, alignment: .top)
            }
            .padding(show ? 30 : 20)
            .padding(.top, show ? 30 : 0)
    //        .frame(width: show ? screen.width : screen.width - 60, height: show ? screen.height : 280)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 460 : 280)
                .background(Color(tag.color))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color(tag.color).opacity(0.3), radius: 20, x: 0, y: 20)
            
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

// this is an extension to make our Double as a whole nnumber without decimal value

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       
        BeginView()
    }
}



struct Tag: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var image: UIImage
    var logo: UIImage
    var color: UIColor
    var show: Bool
}
var tagData = [
    Tag(title: "My Weather Application", subtitle: "Help you to predict", image: #imageLiteral(resourceName: "Card4"), logo: #imageLiteral(resourceName: "card_0"), color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), show: false) ,
    Tag(title: "The Next ", subtitle: "Help you to predict", image: #imageLiteral(resourceName: "Card4"), logo: #imageLiteral(resourceName: "Logo3"), color: UIColor.white, show: false) ,
    Tag(title: "The Next ", subtitle: "Help you to predict", image: #imageLiteral(resourceName: "Card2"), logo: #imageLiteral(resourceName: "Logo3"), color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), show: false)
]

