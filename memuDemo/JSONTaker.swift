//
//  JSONTaker.swift
//  memuDemo
//
//  Created by Dugar Badagarov on 25/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import Foundation
import UIKit

var StringLblText       : String = ""
var StringText          : String = ""
var StringDataField     : String = ""
var StringUrlImg        : String = ""
var StringVideoID       : String = ""
var StringImgURLs       : [String] = [String]()
var StringNavBarTitle   : String = ""

let baseURL = "file:///Users/dugar/Desktop/Andr%20to%20IOS%20000001/"
let donateURL = "http://www.buddhismofrussia.ru/donate/"
let blackView = UIView()

class JSONTaker
{    
    private init () {}
    
    static let shared = JSONTaker()
    
    
    public var location = 0;    
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
                //print (JSON)
                
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
    
    func loadImg(imgURL: String, img1: UIImageView, img2: UIImageView, spinner: UIActivityIndicatorView)-> Void{
        
        spinner.startAnimating()
        let urlURL = URL(string: imgURL)
        
        asyncLoadImage(imageURL: urlURL!,
                       runQueue: DispatchQueue.global(),
                       completionQueue: DispatchQueue.main)
        { result, error in
            guard let image = result
                else {return}
            img1.image = image
            img2.image = image            
            spinner.stopAnimating()
        }        
    } 
    
    func loadImg(imgURL: String, img: UIImageView, spinner: UIActivityIndicatorView)-> Void{
        
        spinner.startAnimating()
        let urlURL = URL(string: imgURL)
        
        asyncLoadImage(imageURL: urlURL!,
                       runQueue: DispatchQueue.global(),
                       completionQueue: DispatchQueue.main)
        { result, error in
            guard let image = result
                else {return}
            img.image = image
            spinner.stopAnimating()
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
    
    func setStatusBarColorOrange ()
    {
        let orangeStatusBar = UIView()
        orangeStatusBar.backgroundColor = UIColor(colorLiteralRed: 1,
                                                   green: 0.62745098,
                                                   blue: 0,
                                                   alpha: 1)
        orangeStatusBar.frame = CGRect(x: 0, y: 0, width: 1000, height: 20)        
        
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(orangeStatusBar)
        }
    }
    
    func makeDark (viewController: UIViewController)
    {		
        
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        blackView.alpha = 0
        //magic numbers ALERT !!!
        UIView.animate(withDuration: 0.725, delay: 0, usingSpringWithDamping: 1.1, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            blackView.alpha = 1
        }, completion: nil)
                       
        viewController.view.addSubview(blackView)
        
    }  
    //post request
    func onPostTapped(API: String, parameters : [String]) {
        
        // let parameters = ["username": "@kilo_loco", "tweet": "HelloWorld"]
        
        guard let url = URL(string: baseURL + API) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody                        
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            
            }.resume()
        
    }
    
    
    func showAlert (title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in 
            alert.dismiss(animated: true, completion: nil)
            
        }))                
        
        viewController.present(alert, animated: true, completion: nil)        
    }
     
}

