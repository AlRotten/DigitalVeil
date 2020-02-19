//
//  DetailedViewController.swift
//  DigitalVeil
//
//  Created by Al Rodríguez on 17/02/2020.
//  Copyright © 2020 Al Rodríguez. All rights reserved.
//

import UIKit

class DetailedViewController :  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var data: [MapModels] = []
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var detailImage: UIImageView!
    
    @IBOutlet weak var appName: UILabel!
    
    @IBOutlet weak var totalTime: UILabel!
    
    var detailName : String?
    var detailImageString : String?
    var filteredData : [MapModels] = []
    
    var totalTimeApp : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appName.text = detailName
        totalTime.text = totalTimeApp
        detailImage.image = UIImage.init(imageLiteralResourceName: detailImageString!)
        
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        data = DataHelpers.parseCsvData()
        filteredData = data.filter({$0.App == detailName})
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "cellDates"
        let dates = filteredData[indexPath.row].Date
        let cell = self.myTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! AppsTableViewCell
        cell.labelDates.text = dates
        
        return cell
    }
    
    
    
}

