//
//  PhotoCell.swift
//  PhotoGalleryApp
//
//  Created by 이택성 on 2022/01/21.
//

import UIKit
import PhotosUI

class photoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!{
        didSet{
            photoImageView.contentMode = .scaleAspectFill
        }
    }
    
    func loadImage(asset: PHAsset) {
        
        let imageManager = PHImageManager()
        let scale = UIScreen.main.scale     // 화면에 한 픽셀을 표현하는데 한 화소가 표현되는게 아니므로 스크린 사이즈에 맞는 수를 곱해줘야함.
        
        let imageSize = CGSize(width: 150 * scale, height: 150 * scale)
        
        let options = PHImageRequestOptions()
        options.deliveryMode = .opportunistic       // 어떤 화질로 가져올건지?
        
        self.photoImageView.image = nil
        
        imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFill, options: options) { image, info  in
//           if (info?[PHImageResultIsDegradedKey] as? Bool ) == true {
//                //
//            self.photoImageView.image = image
//           } else {     //고화질
//
//           }
            
            self.photoImageView.image = image
        }
    }
    
}





