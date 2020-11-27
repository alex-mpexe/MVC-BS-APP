import Foundation
import Alamofire

class CategoryLoader {
    
    typealias categoryCallBack = (_ categories:[Category]?, _ status: Bool, _ message: String) -> Void
    // MARK: - URL
    private var apiUrl = "http://blackstarshop.ru/index.php?route=api/v1/categories"
    
    // MARK: - Services
    func requestFetchCategory(callBack: @escaping categoryCallBack) {
        AF.request(apiUrl).response { response in
            guard let data = response.data else { return }
            do {
                let categories = try JSONDecoder().decode([String:Category].self, from: data)
                callBack(categories.map { $0.value }, true, "")
            } catch {
                callBack(nil, false, error.localizedDescription)
            }
        }
    }
    
}
