//
//  SwipeCell.swift
//  BookingHotel
//
//  Created by Деним Мержан on 31.08.23.
//

import UIKit

class CollectionCell: UICollectionViewCell {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var imageArr = [UIImage?]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView?.register(UINib(nibName: "SwipeCell", bundle: nil), forCellWithReuseIdentifier: "SwipeCell")
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.isPagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        pageControl.backgroundStyle = .prominent
        
    }
    
    
    @IBAction func pageControlTap(_ sender: UIPageControl) {
        let page = sender.currentPage
        collectionView.scrollToItem(at: IndexPath(row: page, section: 0), at: .centeredHorizontally, animated: true)
    }
    
}

extension CollectionCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SwipeCell", for: indexPath) as! SwipeCell
        cell.photoHotel.image = imageArr[indexPath.row]
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    
    
}
