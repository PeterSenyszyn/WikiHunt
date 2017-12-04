//
//  GameViewController.swift
//  WikiHunt
//
//  Created by Peter Senyszyn on 1/5/17.
//  Copyright © 2017 Peter Senyszyn. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import Foundation
import SafariServices

class GameViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var loadingSymbol: UIActivityIndicatorView!
    
    var primScore : Int  = 0 ;
    @IBOutlet weak var score: UILabel!
    
    var primBestScore : Int  = 0 ;
    @IBOutlet weak var bestScore: UILabel!
    
    @IBOutlet weak var at: UILabel!
    @IBOutlet weak var goal: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as? SKView {
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        webView.delegate = self
        
        loadingSymbol.hidesWhenStopped = true
        
        //0BrVSPcZLUbvB6s16bWkMVBl0uXpzAaxNSNJnCRa
        
        if let url = URL(string: "https://en.wikipedia.org/wiki/Special:Random") {
            let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
            present(vc, animated: true)
        }
        
        webView.loadRequest(URLRequest(url: URL(string: "https://en.wikipedia.org/wiki/Special:Random")!))
        //webView.alpha = 0.0
    }
    
    // MARK: - Status Bar Config

    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
    // MARK: - Arrow Functions
    
    @IBAction func leftArrowTouched(_ sender: Any)
    {
        
    }
    
    /**
     *  View loading
     *  - Parameter sender: sender yo
     */
    @IBAction func rightArrowTouched(_ sender: Any)
    {
        
    }
}

extension GameViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        loadingSymbol.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loadingSymbol.stopAnimating()
        
        primScore += 1 ;
        
        score.text = "\(primScore)"
        
        guard let urlString = webView.request?.url?.absoluteString,
            let url = URL(string: urlString) else { return ; }
        
        guard let html = try? String(contentsOf: url, encoding: .ascii) else {
            print("Failed to get HTML")
            return
        }
        
        print(html)
        
        /*let toReplace = "<div class=\"header-container\">"
        
        if (html.range(of: toReplace) != nil)
        {
            //html.
            
            webView.loadHTMLString(html.replacingOccurrences(of: toReplace, with: ""), baseURL: nil)
            
            webView.alpha = 255;
            
            print("yo!")
        }
        
        //let absUrlString: String = (webView.request?.url?.absoluteString)!
        
        //let url = URL(string: absUrlString)
        
        //var html: String = ""
        
        do
        {
            let temp = try String(contentsOf: url, encoding: .ascii)
        }
            
        catch let error
        {
            print("Error: \(error)")
        }
        
        do
        {
            let regex:NSRegularExpression  = try NSRegularExpression(pattern: "<div\\s*(?:class=\"input-wrapper\")?>\\s*(?:<input type=\"search\" name=\"search\" placeholder=\"page\" title=\"Page\" accesskey=\"f\" id=\"searchInput\" class=\"search\" autocomplete=\"off\" readonly=\"\">)?(?:<a title=\"Open main menu\" href=\"\\/wiki\\/Special:MobileMenu\" class=\"mw\\-ui\\-icon mw\\-ui\\-icon\\-element mw\\-ui\\-icon\\-mainmenu main\\-menu\\-button\" id=\"mw\\-mf\\-main\\-menu\\-button\">Open main menu<\\/a>)?\\s*<\\/div>", options: .caseInsensitive)
            let range = NSMakeRange(0, html.characters.count)
            // TODO: - Matching Options
            let htmlStripped:String = regex.stringByReplacingMatches(in: html, options: NSRegularExpression.MatchingOptions(), range:range , withTemplate: "")
            
            webView.loadHTMLString(htmlStripped, baseURL: nil)
        }
        catch
        {
            // ...
        }*/
    }
}
