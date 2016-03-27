//
//  WikiStore.swift
//  RandomWiki
//
//  Created by Kiril Sivokoz on 27/03/2016.
//  Copyright © 2016 Kiril Sivokoz. All rights reserved.
//

import Foundation

class WikiStore: NSObject {

    static let sharedStore = WikiStore()

    private(set) var pages: [[String : String]]
    private let pagesStorageKey = "pages";
    private let defaults = NSUserDefaults.standardUserDefaults()

    override init() {
        if let oldPages = self.defaults.objectForKey(self.pagesStorageKey) {
            self.pages = oldPages as! [[String : String]]
        } else {
            self.pages = []
        }
        super.init()
    }

    func savePage(page: [String : String]) {
        guard page.keys.count > 0 else { return }
        self.pages.append(page)
        self.sync()
    }

    func removePageAtIndex(index: Int) {
        guard index < self.pages.count else { return }
        self.pages.removeAtIndex(index)
        self.sync()
    }

    private func sync() {
        self.defaults.setObject(self.pages, forKey: self.pagesStorageKey)
        self.defaults.synchronize()
    }
}