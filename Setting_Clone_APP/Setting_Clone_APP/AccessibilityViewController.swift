//
//  AccessibilityViewController.swift
//  Setting_Clone_APP
//
//  Created by 이택성 on 2022/01/14.
//

import UIKit

class AccessibilityCell: UITableViewCell {
    
    @IBOutlet weak var leftImageView: UIImageView!
        
    @IBOutlet weak var rightImageView: UIImageView!
    
    @IBOutlet weak var middleTitle: UILabel!
    
}



class AccessibilityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var AccessibilityTableView: UITableView!
    
    var settiingAccessibilityModel = [[SettingModel]]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settiingAccessibilityModel[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settiingAccessibilityModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccessibilityCell", for: indexPath) as! AccessibilityCell
        
        cell.leftImageView.image = UIImage(systemName: settiingAccessibilityModel[indexPath.section][indexPath.row].leftImageName)
        
        cell.middleTitle.text = settiingAccessibilityModel[indexPath.section][indexPath.row].menuTitle
        
        cell.rightImageView.image = UIImage(systemName: settiingAccessibilityModel[indexPath.section][indexPath.row].rightImageName ?? "")
        
        return cell
    }
    

    
    override func viewDidLoad() {
        func makeData() {
            
            settiingAccessibilityModel.append(
                [SettingModel(leftImageName: "textformat.size", menuTitle: "Display & Text Size", subTitle: nil, rightImageName:  "chevron.right"),
            SettingModel(leftImageName: "circlebadge.2", menuTitle: "Motion", subTitle: nil, rightImageName:  "chevron.right"),
            SettingModel(leftImageName: "rectangle.3.group.bubble.left.fill", menuTitle: "Spoken Content", subTitle: nil, rightImageName:  "chevron.right")])
           
            settiingAccessibilityModel.append(
            [SettingModel(leftImageName: "hand.point.up.left.fill", menuTitle: "Touch", subTitle: nil, rightImageName:  "chevron.right"),
            SettingModel(leftImageName: "faceid", menuTitle: "Face ID & Attention", subTitle: nil, rightImageName:  "chevron.right"),
            SettingModel(leftImageName: "keyboard", menuTitle: "Keyboards", subTitle: nil, rightImageName:  "chevron.right")])
      
        }
        
        super.viewDidLoad()
        
        AccessibilityTableView.delegate = self
        AccessibilityTableView.dataSource = self
        
        makeData()
        

        // Do any additional setup after loading the view.
    }


    
}
