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

    class func savePageControllerWithData(data: [String : String]) -> UINavigationController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nav = storyboard.instantiateViewControllerWithIdentifier("savePageViewController") as! UINavigationController
        let save = nav.viewControllers.first as! SavePageViewController
        save.data = data
        return nav
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleField.text = self.data["title"]
    }

    @IBAction func save() {
        print("Saved!")
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}