import Foundation
import Alamofire

class Category: Decodable {
    
    let name: String?
    var iconImage: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case iconImage
    }
}
