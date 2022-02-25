//
//  ViewController.swift
//  PhotoGalleryApp
//
//  Created by 이택성 on 2022/01/21.
//

import UIKit
import PhotosUI

class ViewController: UIViewController {

    var fetchResults: PHFetchResult<PHAsset>?
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "Photo Gallery App"
        makeNavigationItem()
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 1) / 2, height: 200)
        
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        photoCollectionView.collectionViewLayout = layout
        
        photoCollectionView.dataSource = self
    }
    
    func makeNavigationItem() {
        let photoItem = UIBarButtonItem(image: UIImage(systemName: "photo"), style: .done, target: self, action: #selector(checkPermission))
        photoItem.tintColor = .black.withAlphaComponent(0.7)
        
        
        self.navigationItem.rightBarButtonItem = photoItem
        
        let refreshItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .done, target: self, action: #selector(refresh))
        refreshItem.tintColor = .black.withAlphaComponent(0.7)
        
        self.navigationItem.leftBarButtonItem = refreshItem
    }
    
    @objc func checkPermission() {
        
       if PHPhotoLibrary.authorizationStatus() == .authorized || PHPhotoLibrary.authorizationStatus() == .limited{
           DispatchQueue.main.async {
               self.showGallery()
           }
          
       } else if PHPhotoLibrary.authorizationStatus() == .denied {
           DispatchQueue.main.async {
               self.showAuthorizationDeniedAlert()
           }
       } else if PHPhotoLibrary.authorizationStatus() == .notDetermined{
           PHPhotoLibrary.requestAuthorization { status in
               self.checkPermission()// info에 있는 메세지를 띄움
           }
       }
    }
    
    func showAuthorizationDeniedAlert() {
        let alert = UIAlertController(title: "포토라이브러리 접근 권한을 활성화 해주세요.", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "설정으로 가기", style: .default, handler: {action in
            
            guard let url = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func showGallery() {
        let library = PHPhotoLibrary.shared()
        var configuration = PHPickerConfiguration(photoLibrary: library)
        configuration.selectionLimit = 10       // 선택할 사진의 수
        
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
        
        
    }
    
    @objc func refresh() {
        self.photoCollectionView.reloadData()
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fetchResults?.count ?? 0
        
            
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! photoCell
        
        if let asset = self.fetchResults?[indexPath.row] {
            cell.loadImage(asset: asset)

        }
        
        return cell
    }
}

extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        let identifiers = results.map{ $0.assetIdentifier ?? "" }
    
        self.fetchResults = PHAsset.fetchAssets(withLocalIdentifiers: identifiers, options: nil)

        self.photoCollectionView.reloadData()
        
        
        
        self.dismiss(animated: true, completion: nil)

    }
    
}

 
