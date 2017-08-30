//
//  JSONTaker.swift
//  memuDemo
//
//  Created by Dugar Badagarov on 25/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import Foundation
import UIKit

var StringLblText   : String = ""
var StringText      : String = ""
var StringDataField : String = ""
var StringUrlImg    : String = ""
var StringVideoID   : String = ""

let baseURL = "file:///Users/dugar/Desktop/FANATICS/"

class JSONTaker
{
    private init () {}
    
    static let shared = JSONTaker()
    
    var json:[String:AnyObject] = [:]
    let dateFormatter = DateFormatter()          
    
    private func loadJSON (API: String)
    {
        let url=URL(string: baseURL + API + ".json")
        do {
            let allData = try Data(contentsOf: (url)!)
            json = try JSONSerialization.jsonObject(with: allData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
            
           
        }
        catch {
            print(error)
        }
    }
    
    func loadData (API: String, paramNames:[String]) -> [String: [String]]
    {
        loadJSON(API: API)
        var Localparams:[String:[String]] = Dictionary()
        do {
            if let JSON = json["page"] {           
                print (JSON)
                
                for var iParam in paramNames
                {
                    Localparams[iParam] = []
                }
                
                for var index: Int in 0...JSON.count-1 {
                    var aObject = JSON[index] as! [String : AnyObject]  
                                        
                    for var iParam in paramNames
                    {
                        
                        Localparams[iParam]?.append(aObject[iParam] as! String)
                           
                    }                    
                }                
            }
            
        }
        catch {
            print(error)
        }
        
        return Localparams
    }
    
    func convertDate (date: String) -> String
    {        
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
        dateFormatter.locale = Locale.init(identifier: "en_GB")             
        let dateObj = dateFormatter.date(from: (date))
        dateFormatter.dateFormat = "dd-MM-yyyy   hh:mm"
        
        
        if dateObj != nil {
            return dateFormatter.string(from: dateObj!)
        }
        else {
            return ""
        }
    }       
    
    func loadImg(imgURL: String, img: UIImageView, spinner: UIActivityIndicatorView)-> Void{
        
        if spinner != nil {spinner.startAnimating()}
        let urlURL = URL(string: imgURL)
        
        //easier to code, but 10 times slower
        /*          
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: urlURL!)
                DispatchQueue.global().sync {
                    img.image = UIImage(data: data)
                    if spinner != nil {spinner.stopAnimating()}
                }
            }
            catch {
                //print (error)
            }
        }
        */
        
        //harder to code, but faster then commented method above (don't understand why? O_o)
        asyncLoadImage(imageURL: urlURL!,
                       runQueue: DispatchQueue.global(),
                       completionQueue: DispatchQueue.main)
        { result, error in
            guard let image = result
                else {return}
            img.image = image
            if spinner != nil {spinner.stopAnimating()}
        }        
    }  
    
    func asyncLoadImage(imageURL: URL,
                        runQueue: DispatchQueue,
                        completionQueue: DispatchQueue,
                        completion: @escaping (UIImage?, Error?) -> ()) {
        runQueue.async {
            do {
                let data = try Data(contentsOf: imageURL)
                completionQueue.async { completion(UIImage(data: data), nil)}
            } catch let error {
                completionQueue.async { completion(nil, error)}
            }
        }
    }    
    
    func loadVideo (videoCode: String, myWebView: UIWebView) {
        let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
        myWebView.loadRequest(URLRequest(url: url!))        
    }
    
}
