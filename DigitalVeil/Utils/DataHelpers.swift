//
//  DataHelpers.swift
//  DigitalVeil
//
//  Created by Al Rodríguez on 13/02/2020.
//  Copyright © 2020 Al Rodríguez. All rights reserved.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField

class DataHelpers{

    /* ------------------------------------------ Views Static Methods --------------------------------------*/
    
    //Displays an alert with a message depending on the string passed through parameters
    static func displayAlert(userMessage:String, alertType: Int)->UIAlertController{
        let alertTitle: String
        
        switch alertType {
            case 0:
                alertTitle = "There was an error!"
            default:
                alertTitle = "Nice!"
        }
        
        let alert = UIAlertController(title: alertTitle, message: userMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        return alert
    }
    
    /* -------- ActivityIndicator Static Methods --------*/
    
    //Function designed to start or stop the loading spinner animation, the animation state will depend on the bool received as a parameter
    static func toggleLoadingSpinner(animate: Bool, activityIndicator: UIActivityIndicatorView) {
        //Start the spinner animation
        func startSpinner(activityIndicator: UIActivityIndicatorView) {
            activityIndicator.startAnimating()
        }
        
        //Stop the spinner animation
        func stopSpinner(activityIndicator: UIActivityIndicatorView) {
            activityIndicator.stopAnimating()
        }
        
        if (animate) {
            startSpinner(activityIndicator: activityIndicator)
        } else {
            stopSpinner(activityIndicator: activityIndicator)
        }
    }
    
    //ActivityIndicator config
    static func spinnerConfig(activityIndicator: UIActivityIndicatorView, UIView: UIViewController){
        activityIndicator.center = UIView.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.color = .red
    }
    
    /* ------------------------------------------ Input Validation Static Methods --------------------------------------*/
    
    //Email Validation. It has to include an @ and also a dot
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //Password Validation. It has to be at least 8 characaters long and include 1 uppercase character and 1 number
    static func isValidPassword(_ password: String) -> Bool {
        let passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        
        let passPred = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        return passPred.evaluate(with: password)
    }
    
    //Validation of the repeated password input, it only checks if both passwords are identical since we already have feedback from the first password input validation
    static func isValidRepeatedPassword(_ repeatedPassword: String , _ userPassword : String) -> Bool {
        return userPassword == repeatedPassword
    }
    
    static func textFieldOnChangeValidation ( textField: UITextField, userEmail: UITextField, userPassword: UITextField?, userConfirmPassword: UITextField?) {
        if let text = textField.text {
            if let floatingLabelTextField = textField as? SkyFloatingLabelTextFieldWithIcon {
                var errorMessage=""
                switch textField {
                    
                //Email validator call
                case userEmail:
                    if(!DataHelpers.isValidEmail(text)) {
                        errorMessage = "Invalid email"
                    }
                //Password validator call
                case userPassword:
                    if(!DataHelpers.isValidPassword(text)) {
                        errorMessage = "Must contains 8 characters and 1 number"
                    }
                //Repeated pssword validator call
                case userConfirmPassword:
                    if(!DataHelpers.isValidRepeatedPassword(text, userPassword!.text ?? "")) {
                        errorMessage = "Passwords doesn't match"
                    }
                default:
                    errorMessage = ""
                }
                
                //Set the message
                floatingLabelTextField.errorMessage = errorMessage
                
            }
        }
    }
            
    
    /* ------------------------------------------ CSV Static Methods --------------------------------------*/
    
    // TODO CSV URL
    static var path = URL(fileURLWithPath: "/Users/alrodriguez/Desktop/DigitalVeil/DigitalVeil/usage.csv")
    
    //Function designed to parse data from the csv file
    static func parseCsvData ()-> [App] {
        var text:String = ""
        
        do {
            text = try String(contentsOf: path, encoding: .utf8)
            //print(JSONObjectFromTSV(tsvInputString: text, columnNames: ["Date","App","Event","Latitude","Longitude"]))
        } catch {
            print("Error al leer desde fichero")
            
        }
        
        var result: [App] = []
        var rows = text.components(separatedBy: "\n")
        
        //Deleted the first row because it is the tittles row
        rows.remove(at:0)
        
        //Get the every element of the data by looping the array
        for row in rows{
            let column = row.components(separatedBy: ",")
            let usage=App(Date: column[0], App: column[1], Event: column[2], Latitude: Double(column[3])!, Longitude: Double(column[4])!)
            result.append(usage)
        }
        
        return result
    }
    
    //Function designed to parse data from a tsv to JSON
    static func JSONObjectFromTSV(tsvInputString:String, columnNames optionalColumnNames:[String]? = nil) -> Array<NSDictionary> {
        
        //Array of lines
        let lines = tsvInputString.components(separatedBy: "\n")
        guard lines.isEmpty == false else { return [] }
        
        //Initialization
        let columnNames = optionalColumnNames ?? lines[0].components(separatedBy: ",")
        var lineIndex = (optionalColumnNames != nil) ? 0 : 1
        let columnCount = columnNames.count
        var result = Array<NSDictionary>()
        
        //Loop the array to obtain the data and append it to a new array
        for line in lines[lineIndex ..< lines.count] {
            let fieldValues = line.components(separatedBy: ",")
            
            if fieldValues.count != columnCount {
                
            } else {
                result.append(NSDictionary(objects: fieldValues, forKeys: columnNames as [NSCopying]))
            }
            
            lineIndex = lineIndex + 1
        }
        
        return result
    }
    
    /* ------------------------------------------ Apps Management CollectionView Methods --------------------------------------*/
    
    //
    static func getAppDates(dataModel:[App] , app: String)-> Array<String>  {
        var appDates = [String]()
        
        for i in dataModel{
            if(i.App == app){
                appDates.append(i.Date)
            }
        }
        
        return appDates
    }
    
    //
    static func totalMinutesByApp(appDates:[String]) -> Double {
        var arraySeconds = [Double]()
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: " en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        for j in appDates{
            let date = dateFormatter.date(from: j)
            let epoch = date?.timeIntervalSince1970
            
            arraySeconds.append(epoch!)
        }
        
        var arrayOpen = [Double]()
        var arrayClose = [Double]()
        
        for i in 0..<arraySeconds.count{
            
            if i % 2 == 0 {
                print(i)
                arrayOpen.append(arraySeconds[i])
                
            } else {
                arrayClose.append(arraySeconds[i])
                
            }
        }
        //print(arraySeconds)
        
        var arrayResta = [Double]()
        var resta1 : Double
        
        for j in 0..<arrayClose.count{
            resta1 = arrayClose[j] - arrayOpen[j]
            arrayResta.append(resta1)
        }
        
        let totalSeconds : Double = arrayResta.reduce(0, +)
        
        let totalMinutes = (totalSeconds / 60)
        let totalMinutesRounded = Double(round(100 * totalMinutes)/100)
        
        return totalMinutesRounded
    }
}
