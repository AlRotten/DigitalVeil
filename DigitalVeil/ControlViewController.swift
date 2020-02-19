//
//  ControlViewController.swift
//  DigitalVeil
//
//  Created by Al Rodríguez on 18/02/2020.
//  Copyright © 2020 Al Rodríguez. All rights reserved.
//

//ControlCellID

import UIKit

class ControlViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var data : [MapModels] = []
    var filteredData : [MapModels] = []
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
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Cell identification
        let identifier = "ControlCellID"
        let cell = self.myCollectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CollectionViewCell
        
        let appsTime = DataHelpers.getAppDates(dataModel: data, app: filteredData[indexPath.row].App)
        //Set of the labels with all variables
        let name = filteredData[indexPath.row].App
        getImageLiteral(name: name, cell: cell)
        return cell
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
