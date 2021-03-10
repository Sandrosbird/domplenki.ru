//
//  RecentItemsCollectionViewLayout.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 21.01.2021.
//

import UIKit

class RecentItemsCollectionViewLayout: UICollectionViewFlowLayout {
    //MARK: - Properties
    var cacheAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
    var columnsCount = 2
   
    var cellWidth: CGFloat = 150
    private var totalCellsWidth: CGFloat = 0
    
    override func prepare() {
        super.prepare()
        self.scrollDirection = .horizontal
        self.cacheAttributes = [:]
        guard let collectionView = self.collectionView else { return }
        let itemsCount = collectionView.numberOfItems(inSection: 0)
        guard itemsCount > 0 else { return }
        
        let height: CGFloat = 200
        
        var lastX: CGFloat = 20
        var lastY: CGFloat = 0
        
        for index in 0 ..< itemsCount {
            let indexPath = IndexPath(item: index, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            attributes.frame = CGRect(x: lastX, y: lastY, width: self.cellWidth, height: height)
            
            lastX += self.cellWidth + 20
            lastY = 0
            
//            if isLastColumn {
//                lastX = 20
//                lastY += self.cellHeight + 10
//            } else {
//                lastX += width + 30
//            }
            
            cacheAttributes[indexPath] = attributes
            self.totalCellsWidth = lastX
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        super.layoutAttributesForElements(in: rect)
        
        return cacheAttributes.values.filter { (attributes) in
            return rect.intersects(attributes.frame)
        }
    }
    
    override var collectionViewContentSize: CGSize {
        var width: CGFloat = 200
        if self.totalCellsWidth < width {
           
        } else {
            width = totalCellsWidth
        }
        return CGSize(width: width, height: 200)
    }
    
    
}
