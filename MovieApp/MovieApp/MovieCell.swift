//
//  MovieCell.swift
//  MovieApp
//
//  Created by 이택성 on 2022/01/24.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var titleLable: UILabel!{
        didSet {
            titleLable.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            
        }
    }
    @IBOutlet weak var dateLable: UILabel!{
        didSet{
            dateLable.font = UIFont.systemFont(ofSize: 13, weight: .light)
        }
    }
    
    
    @IBOutlet weak var descrirptionLable: UILabel!{
        didSet{
            descrirptionLable.font = UIFont.systemFont(ofSize: 13, weight: .light)
        }
    }
    
    @IBOutlet weak var priceLable: UILabel!{
        didSet{
            priceLable.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        }
    }
    
    @IBOutlet weak var movieImage: UIImageView!
    
    
    
    
}
