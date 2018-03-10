//
//  ViewController.swift
//  DefideDemo
//
//  Created by Kei on 3/9/18.
//  Copyright © 2018 Kei. All rights reserved.
//

import UIKit

class DdHomeViewController: UIViewController {
    
    let numberOfCol: CGFloat = 3
    let spacing: CGFloat = 3
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    var photos: Array<DdPhoto> = []
    
    
    
    var decorator: DdHomeDecorator? {
        didSet {
            decorator?.viewController = self
        }
    }
    
    var presentor: DdHomePresentor? {
        didSet {
            presentor?.viewController = self
        }
    }
    
    var router: DdHomeRouter? {
        didSet {
            router?.viewController = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Home"
        
        decorator = DdHomeDecorator()
        router = DdHomeRouter()
        presentor = DdHomePresentor()
        presentor?.loadPhotos()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router?.prepareForSegue(segue)
    }

}

extension DdHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DdImageCollectionViewCell.cellId, for: indexPath) as! DdImageCollectionViewCell
        cell.photo = photos[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth = (DdGuiConstant.screenWidth - (numberOfCol - 1) * spacing) / numberOfCol
        if indexPath.row % 6 == 4 {
            cellWidth = cellWidth * 2 + spacing
        }
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.openPhotoDetail(photo: photos[indexPath.row])
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard photos.count > 10 else {return}
        
        let visibleIndexPaths = photoCollectionView.indexPathsForVisibleItems
        if (visibleIndexPaths.contains { $0.row == self.photos.count - 4}) {
            self.presentor?.loadPhotos()
        }
    }
}


