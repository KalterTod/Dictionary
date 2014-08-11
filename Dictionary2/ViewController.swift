//
//  ViewController.swift
//  Dictionary2
//
//  Created by Stephen Clark on 8/11/14.
//  Copyright (c) 2014 Stephen Clark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    @IBOutlet var txtViewDefinition: UITextView!
    @IBOutlet var txtFieldWord: UITextField!
    var str = NSString();
    
    @IBAction func btnGetDefinition(sender: UIButton) {
        let word:NSString = txtFieldWord.text
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        var session = NSURLSession(configuration: config)
        let urlPath:NSString = "http://api.wordnik.com:80/v4/word.json/"+word+"/definitions"
        let apiKey: NSString = "6173779924b0a5682c00300ad36091f0c1396c0d361391b93"
        
        //Initialize the urlPath as NSURL
        var url : NSURL = NSURL(string: urlPath)
        
        //Use url to instantiate NSMutableURLRequest
        var request = NSMutableURLRequest(URL: url)
        
        request.addValue(apiKey, forHTTPHeaderField:"api_key")
        
        //Session Data Task to handle the request with completion block
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            //Serialize NSData as a json NSArray object
            let jsonResult : NSArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error:nil) as NSArray
            
            //Set str variable to definition for use in update ViewController
            self.str = jsonResult[0]!["text"] as NSString
            });
        
        task.resume()
        
        //Check for the NSURLSessionDataTask completion block to update str variable every 100ms
        while(str=="") {
            usleep(100)
        }
        
        //Update textView with definition
        txtViewDefinition.text = str
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

