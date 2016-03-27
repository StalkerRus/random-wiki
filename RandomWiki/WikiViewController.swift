//
//  WikiViewController.swift
//  RandomWiki
//
//  Created by Kiril Sivokoz on 27/03/2016.
//  Copyright © 2016 Kiril Sivokoz. All rights reserved.
//

import UIKit

class WikiViewController: UIViewController, UIWebViewDelegate, UIPopoverControllerDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!

    var url: NSURL?

    class func wikiPageControllerWithUrl(urlString: String) -> WikiViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let wiki = storyboard.instantiateViewControllerWithIdentifier("wikiViewController") as! WikiViewController
        wiki.url = NSURL(string: urlString)
        return wiki
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.reload()
    }

    // MARK: Page loading

    func reload() {
        guard let url  = self.url else { return }
        self.webView.loadRequest(NSURLRequest(URL: url))
    }

    func webViewDidStartLoad(webView: UIWebView) {
        self.indicatorView.hidden = false
        self.indicatorView.startAnimating()
        UIView.animateWithDuration(0.25) { 
            self.webView.alpha = 0
        }
    }

    func webViewDidFinishLoad(webView: UIWebView) {
        self.indicatorView.stopAnimating()
        UIView.animateWithDuration(0.25) {
            self.webView.alpha = 1
        }
    }

    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        self.indicatorView.stopAnimating()
        guard let err = error else { return }
        let alert = UIAlertController(title: err.domain,
                                      message: err.localizedDescription,
                                      preferredStyle: .Alert)
        let retry = UIAlertAction(title: "Retry", style: .Default) {
            _ in
            self.reload()
        }
        alert.addAction(retry)
        self.presentViewController(alert, animated: true, completion: nil)
    }

    // MARK: Page saving

    @IBAction func savePage() {
        var title = ""
        guard let url = self.webView.request?.mainDocumentURL else { return }
        if let webTitle = self.webView.stringByEvaluatingJavaScriptFromString("document.title") {
            title = webTitle
        }
        let data = [
            "title" : title,
            "url" : url.absoluteString
        ]
        let vc = SavePageViewController.savePageControllerWithData(data)
        self.presentViewController(vc, animated: true, completion: nil)
    }

    @IBAction func share(sender: UIBarButtonItem) {
        guard let url = self.webView.request?.mainDocumentURL else { return }
        let activities: [AnyObject] = [url]
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: activities, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [
            UIActivityTypePrint,
            UIActivityTypeMessage,
            UIActivityTypeCopyToPasteboard,
            UIActivityTypeAssignToContact,
            UIActivityTypeSaveToCameraRoll,
            UIActivityTypeAirDrop,
            UIActivityTypeAddToReadingList
        ]
        activityViewController.popoverPresentationController?.barButtonItem = sender
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
}
