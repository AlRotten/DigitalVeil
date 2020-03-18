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

    //Initialization
    var data : [App] = []
    var filteredData : [App] = []
    var filterAux : [String] = []
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var beginingDP: UIDatePicker!
    @IBOutlet weak var endingDP: UIDatePicker!
    
    //Dynamic function to get hours by formatting dates from the DatePickers to Calendars
    func formatDate(date:Date) -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let dateString = "\(hour) hours and \(minute) minute/s"
        
        return dateString
    }
    
    //Function that validates and format both dates and calls the function that saves the rule, also gives a response to the user if it is possible to add a new rule.
    func checkDates(){
        let beginingHour = beginingDP.date
        let endingHour = endingDP.date
        
        print(beginingHour)
        print(endingHour)
        
        let beginingHourFormated = formatDate(date: beginingHour)
        let endingHourFormated = formatDate(date: endingHour)
    
        if (beginingHourFormated > endingHourFormated){
            self.present(DataHelpers.displayAlert(userMessage: "Ending hour must be later than begining one", alertType: 0), animated: true, completion: nil)
        } else if (endingHourFormated > beginingHourFormated) {
            //TODO - PETICIÓN DE GUARDADO
            self.present(DataHelpers.displayAlert(userMessage: "Control configuration saved", alertType: 1), animated: true, completion: nil)
        } else if (endingHourFormated == beginingHourFormated) {
            self.present(DataHelpers.displayAlert(userMessage: "Selected times must be different", alertType: 0), animated: true, completion: nil)
        }
    }
    
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
    
    //function that is being called whenever the user press the "Save" button
    @IBAction func saveButton(_ sender: Any) {
        checkDates()
    }
    
}
