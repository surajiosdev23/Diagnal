import Foundation

class RomanticComedyVM {
    weak var delegate: RomanticComedyVMDelegate?
    private var contentItems = [Content]()
    private var currentPage = 1
    private var totalPages = 1 // Default value
    private var isFetchingData = false // Flag to track fetch operation
    var totalItem = 0
    var numberOfItems: Int {
        return contentItems.count
    }
    
    func contentItem(at index: Int) -> Content? {
        guard index < contentItems.count else {
            return nil
        }
        return contentItems[index]
    }
    
    func fetchDataFromJSON(page: Int) {
        if let path = Bundle.main.path(forResource: "CONTENTLISTINGPAGE-PAGE\(page)", ofType: "json") {
            // Check if a fetch operation is already in progress
            guard !isFetchingData else {
                return
            }
            isFetchingData = true
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                let romanticComedyModel = try decoder.decode(RomanticComedyModel.self, from: data)
                if let contentItems = romanticComedyModel.page?.contentItems?.content {
                    for i in 0..<contentItems.count{
                        let item = (romanticComedyModel.page?.contentItems?.content?[i])!
                        self.contentItems.append(item)
                    }
                    self.totalPages = Int(romanticComedyModel.page?.totalContentItems ?? "0") ?? 1
                    self.currentPage = romanticComedyModel.page?.pageNum.flatMap { Int($0) } ?? 1
                    self.totalItem = Int(romanticComedyModel.page?.totalContentItems ?? "0") ?? 0
                    self.delegate?.reloadData()
                } else {
                    self.delegate?.showError(message: "No content found.")
                }
            } catch {
                self.delegate?.showError(message: "Error reading JSON file: \(error.localizedDescription)")
            }
            // Reset the fetch operation flag
            isFetchingData = false
        } else {
            self.delegate?.showError(message: "JSON file not found.")
        }
    }
    func fetchNextPage() {
        guard currentPage < totalPages else {
            return // No more pages to fetch
        }
        currentPage += 1
        fetchDataFromJSON(page: currentPage)
    }
}

protocol RomanticComedyVMDelegate: AnyObject {
    func reloadData()
    func showError(message: String)
}

