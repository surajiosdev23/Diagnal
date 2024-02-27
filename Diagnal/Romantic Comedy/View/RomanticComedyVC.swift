import UIKit

class RomanticComedyVC: UIViewController {
    @IBOutlet weak var ibCollectionView: UICollectionView!
    
    private var viewModel = RomanticComedyVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        viewModel.delegate = self
        viewModel.fetchDataFromJSON(page: 1)
    }
    
    private func setupCollectionView() {
        let edgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let cellHeight = calculateCellHeight(for: ibCollectionView, rowSpacing: 45)
        let flowLayout = setupCollectionViewFlowLayout(withRowHeight: cellHeight, columnCount: 3, itemSpacing: 5, rowSpacing: 45, edgeInsets: edgeInsets)
        ibCollectionView.collectionViewLayout = flowLayout
        ibCollectionView.register(UINib(nibName: "PosterCell", bundle: nil), forCellWithReuseIdentifier: "PosterCell")
    }
    
    private func calculateCellHeight(for collectionView: UICollectionView, rowSpacing: CGFloat) -> CGFloat {
        let availableHeight = collectionView.frame.height - collectionView.contentInset.top - collectionView.contentInset.bottom
        let rows = 3 // Desired number of rows
        let totalRowSpacing = CGFloat(rows - 1) * rowSpacing
        return (availableHeight - totalRowSpacing) / CGFloat(rows)
    }
}

extension RomanticComedyVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as? PosterCell else {
            return UICollectionViewCell()
        }
        if let contentItem = viewModel.contentItem(at: indexPath.row) {
            if let imageName = contentItem.posterImage,
               let image = UIImage(named: "Slices/\(imageName)") {
                cell.ibImage.image = image
            } else {
                // If image doesn't exist, show placeholder
                cell.ibImage.image = UIImage(named: "placeholder_for_missing_posters")
            }
            cell.ibTitle.text = contentItem.name ?? "-"
        } else {
            cell.ibImage.image = UIImage(named: "placeholder_for_missing_posters")
            cell.ibTitle.text = "-"
        }
        return cell
    }
}

extension RomanticComedyVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - screenHeight && viewModel.numberOfItems < viewModel.totalItem{
            // Reached the bottom, trigger loading of next page
            viewModel.fetchNextPage()
        }
    }
}
extension RomanticComedyVC: RomanticComedyVMDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.ibCollectionView.reloadData()
        }
    }

    func showError(message: String) {
        print("Error: \(message)")
        // You can display an alert or other UI component to inform the user about the error.
    }
}

