//
//  DdPhotoFlowLayout.swift
//  DefideDemo
//
//  Created by Kei on 3/9/18.
//  Copyright © 2018 Kei. All rights reserved.
//

import UIKit

class DdPhotoFlowLayout: UICollectionViewFlowLayout {
    
    var minCellWidth: CGFloat = 0
    var cellSpacing: CGFloat = 0
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let numberOfItems = collectionView?.numberOfItems(inSection: 0)
        if numberOfItems == 0 {return super.layoutAttributesForElements(in: rect)}
        if let attributes = super.layoutAttributesForElements(in: rect) {
            for (_, attribute) in attributes.enumerated() {
                if (attribute.representedElementCategory == .cell) {
                    let row = attribute.indexPath.row
                    if  row % 6 == 0 || row % 6 == 1 || row % 6 == 2 { // first line in group 6
                        attribute.frame.origin.x = CGFloat(row % 6) * (minCellWidth + cellSpacing)
                        attribute.frame.origin.y = CGFloat(row / 6) * 3 * (minCellWidth + cellSpacing)
                    } else if row % 3 == 0, row % 2 != 0 { // the 4th - left - in group 6
                        attribute.frame.origin.x = 0
                        attribute.frame.origin.y = CGFloat(row - 1) / 2 * (minCellWidth + cellSpacing)
                    } else if (row - 1) % 3 == 0 && (row - 1) % 2 != 0 { // the biggest item
                        attribute.frame.origin.x = (minCellWidth + cellSpacing)
                        attribute.frame.origin.y = CGFloat(row - 2) / 2 * (minCellWidth + cellSpacing)
                    } else { // the last item - bottom - in group 6
                        attribute.frame.origin.x = 0
                        attribute.frame.origin.y = (CGFloat(row - 3) / 2 + 1) * (minCellWidth + cellSpacing)
                    }
                }
            }
            return attributes
        }
        return nil
    }
    
    override var collectionViewContentSize: CGSize {
        if let collectionView = collectionView {
            let numberOfItems = collectionView.numberOfItems(inSection: 0)
            return CGSize(width: collectionView.bounds.width, height: CGFloat(numberOfItems / 6 ) * 3 * (minCellWidth + cellSpacing))
        }
        return CGSize.zero
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
