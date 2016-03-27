//
//  PageCells.swift
//  RandomWiki
//
//  Created by Kiril Sivokoz on 27/03/2016.
//  Copyright © 2016 Kiril Sivokoz. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    @IBInspectable var shadowColor: UIColor = UIColor.blackColor() {
        didSet {
            self.setNeedsLayout()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.masksToBounds = false;
        self.layer.shadowOpacity = 0.2;
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).CGPath;
        self.layer.shadowOffset = CGSizeMake(1, 1)
        self.layer.shadowColor = self.shadowColor.CGColor
        self.layer.shouldRasterize = true;
        self.layer.rasterizationScale = UIScreen.mainScreen().scale;
    }
    
}

class PageCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    func setPage(page: [String : String]) {
        self.titleLabel.text = page["title"]
    }

}