//
//  ListViewController.swift
//  RandomWiki
//
//  Created by Kiril Sivokoz on 27/03/2016.
//  Copyright © 2016 Kiril Sivokoz. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var pageList: UICollectionView!

    private var pages: [[String : String]] = []

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
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("savedPageCell", forIndexPath: indexPath)
            return cell
        }
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let url = "https://en.wikipedia.org/wiki/Special:Random"
        if !self.isAddPageItemAtIndex(indexPath.row) {

        }
        let controller = WikiViewController.wikiPageControllerWithUrl(url)
        self.navigationController?.pushViewController(controller, animated: true)
    }

    private func isAddPageItemAtIndex(index: Int) -> Bool {
        return index == 0 && self.pages[index].keys.count == 0
    }
}