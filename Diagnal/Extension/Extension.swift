import UIKit
extension UIViewController {
    func setupCollectionViewFlowLayout(withRowHeight rowHeight: CGFloat, columnCount: Int, itemSpacing: CGFloat, rowSpacing: CGFloat, edgeInsets: UIEdgeInsets) -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionViewWidth = UIScreen.main.bounds.width - edgeInsets.left - edgeInsets.right
        let itemWidth = (collectionViewWidth - CGFloat(columnCount - 1) * itemSpacing) / CGFloat(columnCount)
        flowLayout.itemSize = CGSize(width: itemWidth, height: rowHeight)
        flowLayout.minimumInteritemSpacing = itemSpacing
        flowLayout.minimumLineSpacing = rowSpacing
        flowLayout.sectionInset = edgeInsets
        return flowLayout
    }
    func showAlertWith(title: String, message: String, completionHandler: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default) { _ in
            completionHandler?()
        }
        alertController.addAction(okayAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
