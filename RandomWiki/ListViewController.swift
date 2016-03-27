//
//  ListViewController.swift
//  RandomWiki
//
//  Created by Kiril Sivokoz on 27/03/2016.
//  Copyright © 2016 Kiril Sivokoz. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {

    @IBOutlet weak var pageList: UICollectionView!

    private var pages: [[String : String]] = []
    private var cellFormatter: CellFormatter!

    override func viewDidLoad() {
        super.viewDidLoad()
        let isPhone = UIDevice.currentDevice().userInterfaceIdiom == .Phone
        let count = isPhone ? 2 : 5
        self.cellFormatter = CellFormatter(view: self.pageList, itemsOnScreen: count)
        let longPress = UILongPressGestureRecognizer(target: self, action: Selector("handleLongPress:"))
        longPress.delegate = self
        longPress.delaysTouchesBegan = true
        self.pageList.addGestureRecognizer(longPress)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.pages = [[:]]
        self.pages += WikiStore.sharedStore.pages
        self.pageList.reloadData()
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pages.count
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if self.isAddPageItemAtIndex(indexPath.row) {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("newPageCell", forIndexPath: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("savedPageCell", forIndexPath: indexPath) as! PageCell
            cell.setPage(self.pages[indexPath.row])
            return cell
        }
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var url = "https://en.wikipedia.org/wiki/Special:Random"
        if !self.isAddPageItemAtIndex(indexPath.row), let savedUrl = self.pages[indexPath.row]["url"] {
            print("\(url)")
            url = savedUrl
        }
        let controller = WikiViewController.wikiPageControllerWithUrl(url)
        self.navigationController?.pushViewController(controller, animated: true)
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return self.cellFormatter.sizeForCell()
    }

    private func isAddPageItemAtIndex(index: Int) -> Bool {
        return index == 0 && self.pages[index].keys.count == 0
    }

    func handleLongPress(recognizer: UILongPressGestureRecognizer) {
        if recognizer.state != .Ended {
            return
        }
        let point = recognizer.locationInView(self.pageList)
        if let indexPath = self.pageList.indexPathForItemAtPoint(point) where indexPath.row != 0 {
            self.pages.removeAtIndex(indexPath.row)
            self.pageList.reloadData()
            WikiStore.sharedStore.removePageAtIndex(indexPath.row - 1)
        }
    }
}