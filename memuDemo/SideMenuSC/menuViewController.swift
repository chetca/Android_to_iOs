//
//  menuViewController.swift
//  memuDemo
//
//  Created by Parth Changela on 09/10/16.
//  Copyright © 2016 Parth Changela. All rights reserved.
//

import UIKit

class menuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var RandomTextUnderPict: UILabel!
    
    @IBOutlet weak var tblTableView: UITableView!
    @IBOutlet weak var imgProfile: UIImageView!
    
    var randFrazes = ["Да пребудет с вами Будда",
                      "Пусть вам сопутствует удача",
                      "Пусть вас защищают все боги",
                      "Улыбнитесь, всё будет хорошо",
                      "Будьте сильны духом",
                      "Будьте в добром здравии"]
    
    var randIndex = arc4random_uniform(5)
    
    var ManuNameArray:Array = [String]()
    var iconArray:Array = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        ManuNameArray = [
            "Новости",
            "Расписание хуралов",
            "Астрологический прогноз",
            "Дацаны Сангхи", 
            "Историческая справка", 
            "Лекции буддийского университета",
            "Фотоальбом",
            "Видеоальбом",
            "РазРабы"
        ]
        iconArray = [UIImage(named:"home")!,
                     UIImage(named:"defaultIcon")!,
                     UIImage(named:"defaultIcon")!,
                     UIImage(named:"defaultIcon")!
        ]                    
        
        imgProfile.layer.masksToBounds = false
        imgProfile.clipsToBounds = true 
        // Do any additional setup after loading the view.
        
        RandomTextUnderPict.text = randFrazes[Int(randIndex)]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var randIndex = arc4random_uniform(5)
        RandomTextUnderPict.text = randFrazes[Int(randIndex)]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ManuNameArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        
        cell.lblMenuname.text! = ManuNameArray[indexPath.row]
        cell.imgIcon.image = iconArray[1]
        cell.frame.size = CGSize(width: cell.frame.size.width, height: 200)
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let revealviewcontroller:SWRevealViewController = self.revealViewController()        
        let cell:MenuCell = tableView.cellForRow(at: indexPath) as! MenuCell        
        print(cell.lblMenuname.text!)
        
        if cell.lblMenuname.text! == "Новости"
        {
            //print("Home Tapped")
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)            
            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
        }        
        else if cell.lblMenuname.text! == "Расписание хуралов"
        {
            //print("message Tapped")           
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "KhuralScheduleViewController") as! KhuralScheduleViewController
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)            
            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
        }
        else if cell.lblMenuname.text! == "Астрологический прогноз"
        {
            //print("Map Tapped")
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "AstrologicalForecastViewController") as! AstrologicalForecastViewController
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)            
            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
        }
        else if cell.lblMenuname.text! == "Setting"
        {
           print("setting Tapped")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
