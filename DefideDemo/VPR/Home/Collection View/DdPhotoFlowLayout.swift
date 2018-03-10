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
        guard numberOfItems != 0, let attributes = super.layoutAttributesForElements(in: rect) else {return super.layoutAttributesForElements(in: rect)}
        var newAttrs: [UICollectionViewLayoutAttributes] = []
        for (_, attribute) in attributes.enumerated() {
            if (attribute.representedElementCategory == .cell) {
                let newAttr = self.layoutAttributesForItem(at: attribute.indexPath)
                newAttrs.append(newAttr!)
            }
        }
        return newAttrs
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForItem(at: indexPath)?.copy() as! UICollectionViewLayoutAttributes
        let row = attributes.indexPath.row
        if  row % 6 == 0 || row % 6 == 1 || row % 6 == 2 { // first line in group 6
            attributes.frame.origin.x = CGFloat(row % 6) * (minCellWidth + cellSpacing)
            attributes.frame.origin.y = CGFloat(row / 6) * 3 * (minCellWidth + cellSpacing)
        } else if row % 6 == 3 { // the 4th - left - in group 6
            attributes.frame.origin.x = 0
            attributes.frame.origin.y = CGFloat(row - 1) / 2 * (minCellWidth + cellSpacing)
        } else if row % 6 == 4 { // the biggest item
            attributes.frame.origin.x = (minCellWidth + cellSpacing)
            attributes.frame.origin.y = CGFloat(row - 2) / 2 * (minCellWidth + cellSpacing)
        } else { // the last item - bottom - in group 6
            attributes.frame.origin.x = 0
            attributes.frame.origin.y = (CGFloat(row - 3) / 2 + 1) * (minCellWidth + cellSpacing)
        }
        return attributes
    }
    
    override var collectionViewContentSize: CGSize {
        if let collectionView = collectionView {
            let numberOfItems = collectionView.numberOfItems(inSection: 0)
            return CGSize(width: collectionView.bounds.width, height: CGFloat(numberOfItems / 6 ) * 3 * (minCellWidth + cellSpacing) + 10)
        }
        return CGSize.zero
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else {return false}
        return newBounds.height != collectionView.bounds.height
    }
}
