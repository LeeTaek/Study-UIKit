//
//  ProfileCell.swift
//  Setting_Clone_APP
//
//  Created by 이택성 on 2022/01/11.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var topTitle: UILabel!
    @IBOutlet weak var bottomDescription: UILabel!
    
    // nib이 메모리에 올라가는 시점
    override func awakeFromNib() {
        super.awakeFromNib()
        let profileHeight = 60
        
        // 곡률. 보통 height의 반
        profileImageView.layer.cornerRadius = CGFloat(profileHeight / 2)
        
        topTitle.textColor = .blue
        topTitle.font = UIFont.systemFont(ofSize: 20)
        
        bottomDescription.textColor = .darkGray
        bottomDescription.font = UIFont.systemFont(ofSize: 16)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
