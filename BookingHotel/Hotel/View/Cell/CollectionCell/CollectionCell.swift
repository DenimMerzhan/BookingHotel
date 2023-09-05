//
//  SwipeCell.swift
//  BookingHotel
//
//  Created by Деним Мержан on 31.08.23.
//

import UIKit

class CollectionCell: UICollectionViewCell {

    
    @IBOutlet weak var descriptionRoom: UILabel!
    @IBOutlet weak var pageCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    var imageArr = [UIImage?]()
    var tagArr = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pageCollectionView?.register(UINib(nibName: "SwipeCell", bundle: nil), forCellWithReuseIdentifier: "SwipeCell")
        tagCollectionView.register(UINib(nibName: "TagCell", bundle: nil), forCellWithReuseIdentifier: "TagCell")
        
        pageCollectionView?.dataSource = self
        pageCollectionView?.delegate = self
        pageCollectionView?.isPagingEnabled = true
        pageCollectionView?.showsHorizontalScrollIndicator = false
        pageControl.backgroundStyle = .prominent
        
        tagCollectionView.dataSource = self
        tagCollectionView.delegate = self
        
        
    }
    
    
    @IBAction func pageControlTap(_ sender: UIPageControl) {
        let page = sender.currentPage
        pageCollectionView.scrollToItem(at: IndexPath(row: page, section: 0), at: .centeredHorizontally, animated: true)
    }
    
}

extension CollectionCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == pageCollectionView {
            return imageArr.count
        }else {
            return tagArr.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == pageCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SwipeCell", for: indexPath) as! SwipeCell
            cell.photoHotel.image = imageArr[indexPath.row]
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
            cell.descriptionText.text = tagArr[indexPath.row]
            return cell
        }
 
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == pageCollectionView {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }else {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 50))
            label.text = tagArr[indexPath.row]
            return CGSize(width: label.intrinsicContentSize.width, height: 40)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == pageCollectionView {
            pageControl.currentPage = indexPath.row
        }
    }
    
    
}
