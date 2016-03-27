//
//  CellFormatter.swift
//  RandomWiki
//
//  Created by Kiril Sivokoz on 27/03/2016.
//  Copyright © 2016 Kiril Sivokoz. All rights reserved.
//

import Foundation
import UIKit

class CellFormatter: NSObject {

    private weak var view: UIView?
    private let itemsOnScreen: Int
    private let kDefaultRatio: CGFloat = 2 / 3

    init(view: UIView, itemsOnScreen: Int = 2) {
        self.itemsOnScreen = itemsOnScreen
        self.view = view
    }

    func sizeForCell() -> CGSize {
        guard let view = self.view else { return CGSizeZero }
        let itemWidth = floor((view.frame.size.width - self.calculateOffsets()) / CGFloat(self.itemsOnScreen))
        return CGSizeMake(itemWidth, itemWidth / self.kDefaultRatio)
    }

    func calculateOffsets() -> CGFloat {
        let value = 2 * self.contentSideInset() + ((CGFloat(self.itemsOnScreen) + 1) - 2) * self.interitemSpacing()
        return value
    }

    func interitemSpacing() -> CGFloat {
        if let collection = self.view as? UICollectionView, let layout = collection.collectionViewLayout as? UICollectionViewFlowLayout {
            return layout.minimumInteritemSpacing
        }
        return 20.0
    }

    func contentSideInset() -> CGFloat {
        if let collection = self.view as? UICollectionView, let layout = collection.collectionViewLayout as? UICollectionViewFlowLayout {
            return layout.sectionInset.left
        }
        return 20.0
    }
}