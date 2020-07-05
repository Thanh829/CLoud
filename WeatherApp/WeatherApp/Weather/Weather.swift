import Foundation

struct Weather: Codable {
    let current: Double
    let current_humid: Double
    let next: Double
    
}
struct NextWeather: Codable {
    let next : Double
    
}


