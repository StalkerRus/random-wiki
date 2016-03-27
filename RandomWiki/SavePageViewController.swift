//
//  SavePageViewController.swift
//  RandomWiki
//
//  Created by Kiril Sivokoz on 27/03/2016.
//  Copyright © 2016 Kiril Sivokoz. All rights reserved.
//

import UIKit

class SavePageViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!

    var data: [String : String] = [:]

    class func savePageControllerWithData(data: [String : String]) -> SavePageViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let save = storyboard.instantiateViewControllerWithIdentifier("savePageViewController") as! SavePageViewController
        save.data = data
        return save
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleField.text = self.data["title"]
    }

    @IBAction func save() {
        print("Saved!")
        WikiStore.sharedStore.savePage(self.data)
        self.cancel()
    }

    @IBAction func cancel() {
        self.titleField.resignFirstResponder()
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}