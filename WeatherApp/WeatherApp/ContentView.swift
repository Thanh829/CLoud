


import SwiftUI





struct ContentView: View {
    @State private var selected = 0
    @ObservedObject var weather = CurrentWeatherViewModel()
    @ObservedObject var weeklyWeather = FunctionViewModel()
    let timer = Timer.publish(every: 90, on: .main, in: .common).autoconnect()
    private var height = UIScreen.main.bounds.height
    var body: some View {
        
        
        VStack(alignment: .center, spacing: 20) {
           
           
            GeometryReader{ gr in
                CurrentWeather(weather: self.weather.current, height: self.selected == 0 ? gr.size.height : gr.size.height * 1.1).animation(.easeInOut(duration: 0.5))
            }.onReceive(self.timer) {(_) in
                self.weather.fetch()
            }
            FunctionView (value: selected, height: height*0.5, CurrentTemp: Double(self.weather.current?.current ?? 0), NextTemp: self.weather.current?.next ?? 0)
           
            VStack{
                Picker("", selection: $selected){
                    Text("Current")
                        .tag(0)
                    Text("Other Features")
                        .tag(1)
                }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal)
            }
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
        
    
}




