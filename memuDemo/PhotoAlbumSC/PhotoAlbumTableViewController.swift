//
//  PhotoAlbumTableViewController.swift
//  memuDemo
//
//  Created by Dugar Badagarov on 31/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class PhotoAlbumTableViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {        

    @IBOutlet var btnMenuButton: UIBarButtonItem!
    @IBOutlet var photoCollectionView: UICollectionView!
    
    var album:[String:[String]] = [String:[String]]()
    var albumIndex:[String] = [String]()
    
    var paramDict: [String:[String]] = Dictionary()
    var itemSize:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if revealViewController() != nil {                        
            
            btnMenuButton.target = revealViewController()                        
            btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))            

            paramDict = JSONTaker.shared.loadData(API: "photos", paramNames: ["title", "image", "album", "date"])            
        }

        
        
        for var i: Int in 0...(paramDict["title"]?.count)!-1 {                
            //album[String((paramDict["album"]?[i])!)!]?.append((paramDict["image"]?[i])!)
            album[paramDict["album"]?[i] as! String] = []
            album[paramDict["album"]?[i] as! String]?.append(paramDict["image"]?[i] as! String)
            print(album[paramDict["album"]?[i] as! String]?.count)
            
        }
        
        var indus = 0;
        
        print(album.isEmpty)
        print(album)
        for var alKye in album.keys {            
            albumIndex.append(alKye)
        }
        
        print (albumIndex)
        
        itemSize = (UIScreen.main.bounds.width-16)/2 - 4
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(8, 0, 9, 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize*0.9)
        
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        
        photoCollectionView.collectionViewLayout = layout        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print ((collectionView.cellForItem(at: indexPath) as! AlbumCollectionCell).title.text)
        
        //StringImgURLs = (paramDict["images"]?[indexPath.row].components(separatedBy: "\n"))!
        
        StringNavBarTitle = (paramDict["title"]?[indexPath.row])!
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return album.keys.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCollectionCell", for: indexPath) as! AlbumCollectionCell
        
        //realization with old json         
        /*
         
        cell.title.text = (paramDict["title"]?[indexPath.row])! 
        cell.photosCnt.text = String((paramDict["images"]?[indexPath.row])!.components(separatedBy: "\n").count)
                
         cell.title.layer.zPosition = 1
         cell.photosCnt.layer.zPosition = 1
        
        cell.title.textColor = UIColor.white
        cell.photosCnt.textColor = UIColor.white
        
        cell.title.sizeToFit()
        cell.photosCnt.sizeToFit()
        
        cell.backgroundLbl.backgroundColor = UIColor(white: 0, alpha: 0.66)                        
        
        cell.titleWidthConstraint.constant = itemSize*0.8
        
        cell.photosCnt.frame = CGRect(x: cell.photosCnt.bounds.origin.x - cell.photosCnt.bounds.width, 
                                      y: cell.photosCnt.bounds.origin.y, 
                                      width: cell.photosCnt.bounds.width, 
                                      height: cell.photosCnt.bounds.height)
        
        cell.photosCnt.textAlignment = NSTextAlignment.right
        
        
        JSONTaker.shared.loadImg(imgURL: (paramDict["image"]?[indexPath.row])!, img: cell.img, spinner: cell.spinner)      
        */
        
        cell.title.text = "default title"  
        
        
        
        cell.photosCnt.text = (album[albumIndex[indexPath.row]]?.count as! Int) as! String
        
        cell.title.layer.zPosition = 1
        cell.photosCnt.layer.zPosition = 1
        
        cell.title.textColor = UIColor.white
        cell.photosCnt.textColor = UIColor.white
        
        cell.title.sizeToFit()
        cell.photosCnt.sizeToFit()
        
        cell.backgroundLbl.backgroundColor = UIColor(white: 0, alpha: 0.66)          
        cell.titleWidthConstraint.constant = itemSize*0.8
        
        cell.photosCnt.frame = CGRect(x: cell.photosCnt.bounds.origin.x - cell.photosCnt.bounds.width, 
                                      y: cell.photosCnt.bounds.origin.y, 
                                      width: cell.photosCnt.bounds.width, 
                                      height: cell.photosCnt.bounds.height)
        
        cell.photosCnt.textAlignment = NSTextAlignment.right
        
        JSONTaker.shared.loadImg(imgURL: album[albumIndex[indexPath.row]]![0], img: cell.img, spinner: cell.spinner)     
        
        return cell
    }       
}
