//
//  NewsDetailsViewController.swift
//  PlayoTask
//
//  Created by Kripa Tripathi on 21/06/22.
//

import UIKit
import WebKit

class NewsDetailsViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var urlData = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let web_url = URL(string:urlData)!
        let web_request = URLRequest(url: web_url)
        webView.load(web_request)
    }
}
