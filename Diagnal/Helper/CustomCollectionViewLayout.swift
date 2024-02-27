//
//  CustomCollectionViewLayout.swift
//  Diagnal
//
//  Created by suraj jadhav on 26/02/24.
//

import UIKit

class CustomCollectionViewLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let spacing: CGFloat = 30
        let margin: CGFloat = 30
        
        let availableWidth = collectionView.bounds.width - (margin * 2) - (spacing * 2)
        let itemWidth = availableWidth / 3
        let itemHeight = itemWidth
        
        itemSize = CGSize(width: itemWidth, height: itemHeight)
        minimumLineSpacing = spacing
        minimumInteritemSpacing = spacing
        sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
