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
var StringText  : String = ""
var StringDataField : String = ""
var StringUrlImg    : String = ""

class JSONTaker
{
    private init () {}
    
    static let shared = JSONTaker()
    
    var json:[String:AnyObject] = [:]
    let dateFormatter = DateFormatter()
    
    private func loadJSON (baseURL: String)
    {
        let url=URL(string: baseURL)
        do {
            let allData = try Data(contentsOf: (url)!)
            json = try JSONSerialization.jsonObject(with: allData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
            
           
        }
        catch {
            print(error)
        }
    }
    
    func loadData (baseURL: String, paramNames:[String]) -> [String: [String]]
    {
        loadJSON(baseURL: baseURL)
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
        
        return dateFormatter.string(from: dateObj!)
    }
    
    func loadImg (url: String) -> UIImage
    {
        print("Хуяк")     
        print(url)
        let url = URL(string: url)
        let data = try? Data(contentsOf: url!)
        
        if let imageData = data
        {
            return UIImage(data: data!)!
        }
        
        return UIImage()
    }
}
