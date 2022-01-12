//
//  ViewController.swift
//  Setting_Clone_APP
//
//  Created by 이택성 on 2022/01/11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var settingTableView: UITableView!
    
    var settingModel = [[SettingModel]]()
    
    
    func makeData() {
        settingModel.append([SettingModel(leftImageName: "person.circle", menuTitle: "Sign in to your iPhone", subTitle: "Set up iCloud, the App Store", rightImageName: nil)])
        
        settingModel.append([SettingModel(leftImageName: "gear", menuTitle: "General", subTitle: nil, rightImageName: "chevron.right"),
        SettingModel(leftImageName: "person.fill", menuTitle: "Accessibility", subTitle: nil, rightImageName: "chevron.right"),
        SettingModel(leftImageName: "hand.raised.fill", menuTitle: "Privacy", subTitle: nil, rightImageName: "chevron.right")])
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.backgroundColor = UIColor(white: 250/255, alpha: 1)
        
        // tableView에 다른 nib으로 작성한 cell을 등록하는 코드
        settingTableView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: "ProfileCell")
         
        settingTableView.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "MenuCell")
        
        makeData()
        
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    // 구현할 셀의 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingModel[section].count

    }
    
    // 섹션의 수
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingModel.count
    }
    
    //어떤 순서로 셀을 테이블에 보여줄거냐?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        //   첫번째에만 profile cell
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
            
            cell.topTitle.text = settingModel[indexPath.section][indexPath.row].menuTitle
            cell.profileImageView.image = UIImage(systemName: settingModel[indexPath.section][indexPath.row].leftImageName)
            cell.bottomDescription.text = settingModel[indexPath.section][indexPath.row].subTitle
            
            return cell
        }
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        
        cell.leftImageView.image = UIImage(systemName: settingModel[indexPath.section][indexPath.row].leftImageName)
        cell.leftImageView.tintColor = .red
        cell.middleTitle.text = settingModel[indexPath.section][indexPath.row].menuTitle
        cell.rightImageView.image = UIImage(systemName: settingModel[indexPath.section][indexPath.row].rightImageName ?? "")
        
        
        return cell
    }
    
    // 높이를 무조건 고정
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
//
   
    
    
}

