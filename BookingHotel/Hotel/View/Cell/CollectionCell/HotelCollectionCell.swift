//
//  SwipeCell.swift
//  BookingHotel
//
//  Created by Деним Мержан on 31.08.23.
//

import UIKit

class HotelCollectionCell: UITableViewCell {
    

    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var pageCollectionView: UICollectionView!
    
    var imageArr = [UIImage?]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        pageCollectionView?.register(UINib(nibName: "SwipeCell", bundle: nil), forCellWithReuseIdentifier: "SwipeCell")
        pageCollectionView?.dataSource = self
        pageCollectionView?.delegate = self
        pageCollectionView?.isPagingEnabled = true
        pageCollectionView?.showsHorizontalScrollIndicator = false
        pageControl.backgroundStyle = .prominent
        
        
    }
    
    @IBAction func pageControlTapped(_ sender: UIPageControl) {
        let page = sender.currentPage
        if page < pageCollectionView.numberOfItems(inSection: 0) {
            pageCollectionView.scrollToItem(at: IndexPath(row: page, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
}

extension HotelCollectionCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
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
