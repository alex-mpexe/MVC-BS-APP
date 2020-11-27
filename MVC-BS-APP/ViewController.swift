import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var categories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let loader = CategoryLoader()
        loader.requestFetchCategory { [weak self] (categories, status, message) in
            if status {
                guard let self = self else {return}
                guard let _categories = categories else { return }
                self.categories = _categories.filter { $0.iconImage != "" }.map { category in
                    category.iconImage = "http://blackstarshop.ru/\(category.iconImage!)"
                    return category
                }
                self.tableView.reloadData()
                
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CategoryCell
        cell.categoryLabel.text = categories[indexPath.row].name
        let iconUrl: URL? = URL(string: categories[indexPath.row].iconImage ?? "")
        cell.categoryIcon.load(url: iconUrl!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70.0
    }
    
}
