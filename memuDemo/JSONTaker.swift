//
//  JSONTaker.swift
//  memuDemo
//
//  Created by Dugar Badagarov on 25/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

extension UILabel {
    func setHTML(html: String) {           
        do {               
            let at : NSAttributedString = try NSAttributedString(data: html.data(using: .utf8)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil);                        
            self.attributedText = at;
        } catch {
            self.text = html;
        }
        font = UIFont(name: "Helvetica", size: 14)
    }
}

var StringLblText       : String = ""
var StringText          : String = ""
var StringDataField     : String = ""
var StringUrlImg        : String = ""
var StringVideoID       : String = ""
var StringImgURLs       : [String] = [String]()
var StringNavBarTitle   : String = ""

let baseURL = "file:///Users/dugar/Desktop/AndrtoIOS/FANATICS/"
//let baseURL = "http://192.168.3.225"
let donateURL = "http://www.buddhismofrussia.ru/donate/"
let blackView = UIView()

class JSONTaker
{    
    private init () {}
    
    static let shared = JSONTaker()
    
    
    public var location = 0;    
    var json:[String:AnyObject] = Dictionary()
    let dateFormatter = DateFormatter()          
    
    private func loadJSON (API: String)
    {
        let url=URL(string: baseURL + API + ".json")
        //let url=URL(string: baseURL + "/api/" + API)
        var allData = Data()
        do {
            allData = try Data(contentsOf: (url)!)                                
            
            var strData = String(data: allData, encoding: .utf8)
            //print (strData!)            
            var strJSON = String(data: allData, encoding: .utf8)            
                                    
            var validStrJSON = "{\n  \"page\":" + strJSON! + "\n}"            
            
            print (validStrJSON)
            
            let arr: [UInt8] = Array(validStrJSON.utf8)
            allData = Data(arr)
            
            let tryJSON = try JSONSerialization.jsonObject(with: allData, options: JSONSerialization.ReadingOptions.allowFragments)
                        
            json = tryJSON as! [String: AnyObject]
        }
        catch {
            print(error)
            //someone developed the server, which can only send FUCKING invalid json file (whith out FUCKING key value).
            //So that there we add key value by reading the data and changing it
            //data -> String -> [+ "\"page\":" +] -> data -> JSONSerialization 
            
            
            /*
            var strJSON = String(data: allData, encoding: .utf8)
            strJSON?.remove(at: (strJSON?.startIndex)!)
            strJSON?.remove(at: (strJSON?.startIndex)!)
            
            var validStrJSON = "{\n  \"page\":" + strJSON!
            
            let arr: [UInt8] = Array(validStrJSON.utf8)
            allData = Data(arr)
            
            do {
                json = try JSONSerialization.jsonObject(with: allData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
                
                print ("error above has been solved !!! \n >_> \n <_<")
            }
            catch {
                print (error)
            }    
            */
        }
    }
    
    func loadData (API: String, paramNames:[String]) -> [String: [String]]
    {
        loadJSON(API: API)
        var Localparams:[String:[String]] = Dictionary()
        do {            
            if let JSONN = json["page"] {                           
                
                for var iParam in paramNames { Localparams[iParam] = [] }                                
                
                for var index in 0...JSONN.count-1 {     
                    var aObject = (JSONN[index]) as! [String : AnyObject]  
                                        
                    for var iParam in paramNames {               
                        if (iParam == "id" || iParam=="album") {
                            Localparams[iParam]?.append(String(aObject[iParam] as! Int))
                        }                        
                        else {
                            Localparams[iParam]?.append(aObject[iParam] as! String)
                        }
                    }                    
                }                
            }
            else {
                for var iParam in paramNames { Localparams[iParam] = [] }
                                
                for var index in 0...paramNames.count-1 {
                    if paramNames[index] == "id" || paramNames[index] == "album" {
                        Localparams[paramNames[index]]?.append("1")
                    }
                    else {
                        Localparams[paramNames[index]]?.append("asd")
                        if paramNames[index] == "image" {
                            Localparams[paramNames[index]]?[0].append("https://pp.userapi.com/c626223/v626223942/3702a/xNEpeD7Eggk.jpg")
                        }
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
    
    func loadImg(imgURL: String, img: UIImageView, spinner: UIActivityIndicatorView, imgHeightConstraint: NSLayoutConstraint)-> Void{
        
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        let urlURL = URL(string: imgURL)
        
        if let lru = urlURL {         
            asyncLoadImage(imageURL: urlURL!,
                           runQueue: DispatchQueue.global(),
                           completionQueue: DispatchQueue.main)
            { result, error in
                guard let image = result
                    else {return}
                img.image = image                
                
                DispatchQueue.main.async(execute: {
                    while (true) {
                        if img.bounds.width != 0.0 {
                            imgHeightConstraint.constant = img.bounds.width * ((img.image?.size.height)!/(img.image?.size.width)!)
                            
                            print (img.bounds.width)
                            print ((img.image?.size.height))
                            print (img.image?.size.width)
                            
                            img.frame = CGRect(x: img.frame.origin.x,
                                               y: img.frame.origin.y,
                                               width: img.frame.width,
                                               height: imgHeightConstraint.constant)
                            
                            print ("imgFrame", img.frame)
                            
                            return
                        }
                    }                    
                })                                               
                
                spinner.stopAnimating()            
            }        
        }
        else {
            print ("error img url, baka")
        }
    } 
    
    func loadImg(imgURL: String, img1: UIImageView, img2: UIImageView, spinner: UIActivityIndicatorView)-> Void{
        
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
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
        spinner.hidesWhenStopped = true
        let urlURL = URL(string: imgURL)
        
        if let lru = urlURL {         
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
        else {
            print ("error img url, baka")
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
        myWebView.isHidden = true        
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
    
    func onPostTapped(API: String, parameters : [String : String] ) {
        
        //  let parameters = ["username": "@kilo_loco", "tweet": "HelloWorld"]
        
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
    
    func fromHTMLToAdequate (HTML: String) -> String {
        
        var html = HTML    
        
        while (html.characters.first != Character("\"")) {
            html.remove(at: html.startIndex)            
        }
        
        print (html)

        html.remove(at: html.startIndex)
        var adequate = ""
        
        while (html.characters.first != Character("\"")) {
            adequate.append(html.remove(at: html.startIndex))
        }
        
        var adeq = ""
        
        while (adequate.characters.last != Character("/")) {
            adeq.append(adequate.characters.removeLast())
        }
        
        adeq = String(adeq.characters.reversed())
        
        print (adeq)
        return adeq
    }
     
}

