//
//  ViewController.swift
//  TweetsAnalyser
//
//  Created by Aanchal Patial on 30/06/19.
//  Copyright © 2019 AP. All rights reserved.
//

import UIKit
import SwifteriOS
import SwiftyJSON
import CoreML

class ViewController: UIViewController , UITextFieldDelegate{
    
    //MARK: Variables

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var analyseButton: UIButton!
    
    // Instantiation using Twitter's OAuth Consumer Key and secret
    let swifter = Swifter(consumerKey: "AoaMzhn4B4VcCVphkCGu3VrB7", consumerSecret: "LY3pZQDiq7GBBOgecA9qNR1ZisVWj81meTZGDReuhQRg9ngYx9")
    
    let sentimentClassifier = TweetSentimentClassifier()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        analyseButton.layer.cornerRadius = 7
        analyseButton.clipsToBounds = true
        textField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
        
    }

    @IBAction func analyseButtonPressed(_ sender: UIButton) {
        fetchTweets()
    }
    
    
    func fetchTweets() {
        if let keyword = textField.text {
            swifter.searchTweet(using: keyword, lang: "en", count: 100, tweetMode : .extended, success: { (results, metadata) in
                
                //JSON Parsing
                var tweetArray = [TweetSentimentClassifierInput]()
                for i in 0..<100 {
                    if let tweet = results[i]["full_text"].string{
                        let tweetToAnalyse = TweetSentimentClassifierInput(text: tweet)
                        tweetArray.append(tweetToAnalyse)
                    }
                }
                self.makePrediction(with: tweetArray)
                
            }) { (error) in
                print("Error with Twitter API requets \(error)")
            }
        }
    }
    
    func makePrediction(with tweetArray : [TweetSentimentClassifierInput]) {
        
        do{
            let predictions = try self.sentimentClassifier.predictions(inputs: tweetArray)
            var score : Int = 0
            for pred in predictions {
                let sentiment = pred.label
                if sentiment == "Pos" {
                    score += 1
                }else if sentiment == "Neg" {
                    score -= 1
                }else if sentiment == "Neutral"{
                    //do nothing
                }
            }
            
            updateUI(with: score)
            
        }catch {
            print("Error making prediction.")
        }
    }
    
    func updateUI(with score : Int){
        
        if score > 20 {
            emojiLabel.text = "😀"
        }else if score > 10 {
            emojiLabel.text = "🙂"
        }else if score > -10 {
            emojiLabel.text = "😟"
        }else if score < -10 {
            emojiLabel.text = "😖"
        }
    }
    
    @objc func viewTapped() {
        textField.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.2) {
            self.heightConstraint.constant = 258
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2) {
            self.heightConstraint.constant = 144
            self.view.layoutIfNeeded()
        }
    }
}

