//
//  CategoryLayout.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 15.02.2021.
//

import UIKit

class CategoryLayout: UICollectionViewFlowLayout {
    //MARK: - Properties
    var cacheAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
    var columnsCount = 2
    var cellHeight: CGFloat = 90
    private var totalCellsHeight: CGFloat = 0
    
    override func prepare() {
        super.prepare()
        self.scrollDirection = .vertical
        self.cacheAttributes = [:]
        guard let collectionView = self.collectionView else { return }
        let itemsCount = collectionView.numberOfItems(inSection: 0)
        guard itemsCount > 0 else { return }
        
        let width = collectionView.frame.width / 2.5
        
        var lastX: CGFloat = 20
        var lastY: CGFloat = 10
        
        for index in 0 ..< itemsCount {
            let indexPath = IndexPath(item: index, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            attributes.frame = CGRect(x: lastX, y: lastY, width: width, height: self.cellHeight)
            let isLastColumn = (index + 1) % (self.columnsCount) == 0 || index == itemsCount - 1
            
            if isLastColumn {
                lastX = 20
                lastY += self.cellHeight + 10
            } else {
                lastX += width + 30
            }
            
            cacheAttributes[indexPath] = attributes
            self.totalCellsHeight = lastY
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        super.layoutAttributesForElements(in: rect)
        
        return cacheAttributes.values.filter { (attributes) in
            return rect.intersects(attributes.frame)
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: self.collectionView?.frame.width ?? 0, height: self.totalCellsHeight)
    }
    
    
}
