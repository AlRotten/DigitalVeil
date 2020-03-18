//
//  ManagementViewController.swift
//  DigitalVeil
//  Created by Al Rodríguez on 17/02/2020.
//  Copyright © 2020 Al Rodríguez. All rights reserved.
//

import UIKit

class ManagementViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //Initialization
    var data : [App] = []
    var filteredData : [App] = []
    var filterAux : [String] = []
    
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myCollectionView.dataSource = self
        self.myCollectionView.delegate = self
        
        data = DataHelpers.parseCsvData()
        
        //Filter the data array in order to show only one app icon. TODO
        for element in data {
            if (filterAux.contains(element.App)) {
               
            } else {
                filterAux.append(element.App)
                filteredData.append(element)
            }
            
        }
        
        print(filteredData)
    }
    
    // Function called before the view is loaded
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    //Collection View Cell function
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Cell identification
        let identifier = "AppsCellID"
        let cell = self.myCollectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CollectionViewCell
        let name = filteredData[indexPath.row].App
        var event = filteredData[indexPath.row].Event
        
        //Switch of the event
        switch event {
            case "opens":
                event = "Opened"
            case "closes":
                event = "Closed"
            default:
                break
        }
        
        let appsTime = DataHelpers.getAppDates(dataModel: data, app: filteredData[indexPath.row].App)
        let totalMinutes = DataHelpers.totalMinutesByApp(appDates: appsTime)
        
        //Set of the labels with all variables
        cell.itemLabel.text = name
        
        var hours: Double
        var mins: Double
        var seconds: Double
        var newMins: Double
        
        switch totalMinutes {
            case 0..<1:
                cell.itemLabelTime.text = "\(String(format: "%.0f", totalMinutes  * 60)) Seconds"
            
            case 1..<60:
                var seconds = (100 * totalMinutes.truncatingRemainder(dividingBy: 1)) / 60
                print(seconds)
                var mins = Double(integerLiteral: totalMinutes)
                print(mins)
                if (seconds > 59) {
                    newMins = seconds + mins
                } else {
                    newMins = mins
                }
                
                cell.itemLabelTime.text = "\(String(format: "%.2f", newMins)) Mins"
            
            default:
                var mins = floor(totalMinutes)
                print(totalMinutes.truncatingRemainder(dividingBy: 1))
                var seconds = (totalMinutes.truncatingRemainder(dividingBy: 1)) * 60
                print(seconds)
           
                print(mins)
                if (seconds > 59) {
                    newMins = seconds + mins
                } else {
                    newMins = mins
                }
                
                print(newMins)
                
                cell.itemLabelTime.text = " \(String(format: "%.0f", newMins)) Mins"
        }
        
        cell.eventLabel.text = event
        getImageLiteral(name: name, cell: cell)
        return cell
    }
    
    // "Prepare for segue" calling because the need of data on the Detailed View of every app. It is called whenever it's pressed an app cell from the main apps navigation.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let item = (sender as? CollectionViewCell)
        let indexPath = self.myCollectionView.indexPath(for: item!)
        let name = filteredData[indexPath!.row].App
        
        let appsTime = DataHelpers.getAppDates(dataModel: data, app: name)
        
        let totalMinutes = DataHelpers.totalMinutesByApp(appDates: appsTime)
        
        let detailedVC = segue.destination as! DetailedViewController
        detailedVC.detailName = name
        detailedVC.totalTimeApp = "Total minutes:  \(totalMinutes)"
        
        detailedVC.detailImageString = getImageLiteral(name: filteredData[indexPath!.row].App)
    }
    
    //Function to get the real reference for every image
    func getImageLiteral(name: String, cell: CollectionViewCell) {
        //Switch of the image name
        switch (name){
        case ("Instagram"):
            cell.itemImage.image =  UIImage.init(imageLiteralResourceName: "instagram")
            break;
        case ("Chrome"):
            cell.itemImage.image =  UIImage.init(imageLiteralResourceName: "chrome")
            break;
        case ("Whatsapp"):
            cell.itemImage.image =  UIImage.init(imageLiteralResourceName: "whatsapp")
            break;
        case ("Facebook"):
            cell.itemImage.image =  UIImage.init(imageLiteralResourceName: "facebook")
            break;
        case ("Reloj"):
            cell.itemImage.image =  UIImage.init(imageLiteralResourceName: "clock")
            break;
        case ("Gmail"):
            cell.itemImage.image =  UIImage.init(imageLiteralResourceName: "gmail")
            break;
        default:
            break
        }
    }
    
    //Function to get the real reference for every image, this one is design to pass the string to the next view
    func getImageLiteral(name: String) -> String {
        //Switch of the image name
        var newName:String
        
        switch (name){
            case ("Instagram"):
                newName = "instagram"
                break;
            case ("Chrome"):
                newName = "chrome"
                break;
            case ("Whatsapp"):
                newName = "whatsapp"
                break;
            case ("Facebook"):
                newName = "facebook"
                break;
            case ("Reloj"):
                newName = "clock"
                break;
            case ("Gmail"):
                newName = "gmail"
                break;
            default:
                newName = ""
                break
        }
        
        return newName
    }
    
}
