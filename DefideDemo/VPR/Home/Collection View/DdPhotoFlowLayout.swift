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
    
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        guard
            let numberOfItems = collectionView?.numberOfItems(inSection: 0),
            numberOfItems != 0
        else {return super.prepare()}
        
        for i in cache.count ..< numberOfItems {
            let indexPath = IndexPath(row: i, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = self.frameForItem(at: indexPath)
            cache.append(attributes)
        }
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.row]
    }
    
    private func frameForItem(at indexPath: IndexPath) -> CGRect {
        let row = indexPath.row
        var frame = CGRect.zero
        frame.size.height = minCellWidth
        frame.size.width = minCellWidth
        if  row % 6 == 0 || row % 6 == 1 || row % 6 == 2 { // first line in group 6
            frame.origin.x = CGFloat(row % 6) * (minCellWidth + cellSpacing)
            frame.origin.y = CGFloat(row / 6) * 3 * (minCellWidth + cellSpacing)
        } else if row % 6 == 3 { // the 4th - left - in group 6
            frame.origin.x = 0
            frame.origin.y = CGFloat(row - 1) / 2 * (minCellWidth + cellSpacing)
        } else if row % 6 == 4 { // the biggest item
            frame.origin.x = (minCellWidth + cellSpacing)
            frame.origin.y = CGFloat(row - 2) / 2 * (minCellWidth + cellSpacing)
            frame.size.width = minCellWidth * 2 + cellSpacing
            frame.size.height = minCellWidth * 2 + cellSpacing
        } else { // the last item - bottom - in group 6
            frame.origin.x = 0
            frame.origin.y = (CGFloat(row - 3) / 2 + 1) * (minCellWidth + cellSpacing)
        }
        return frame
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
