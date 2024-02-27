//
//  Extension.swift
//  Diagnal
//
//  Created by suraj jadhav on 26/02/24.
//

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
}
