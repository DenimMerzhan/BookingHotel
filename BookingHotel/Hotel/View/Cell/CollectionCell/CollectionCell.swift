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
    @IBOutlet weak var heightTagCollection: NSLayoutConstraint!
    
    var imageArr = [UIImage?]()
    var tagArr = [String]()
    var room: Room?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pageCollectionView?.register(UINib(nibName: "SwipeCell", bundle: nil), forCellWithReuseIdentifier: "SwipeCell")
        tagCollectionView.register(UINib(nibName: "TagCell", bundle: nil), forCellWithReuseIdentifier: "TagCell")
        
        pageCollectionView?.dataSource = self
        pageCollectionView?.delegate = self
        pageCollectionView?.isPagingEnabled = true
        pageCollectionView?.showsHorizontalScrollIndicator = false
        pageControl.backgroundStyle = .prominent
        
        tagCollectionView.isScrollEnabled = false
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
        guard let room = room else {return 0}
        if collectionView == pageCollectionView {
            return room.imageArr.count
        }else {
            return room.tagRoom.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let room = room else {return UICollectionViewCell()}
        if collectionView == pageCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SwipeCell", for: indexPath) as! SwipeCell
            cell.photoHotel.image = room.imageArr[indexPath.row]
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
            cell.descriptionText.text = room.tagRoom[indexPath.row]
            return cell
        }
 
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == pageCollectionView {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }else {
            guard let tag = room?.tagRoom[indexPath.row] else {return CGSize.zero}
            return CGSize(width: tag.contentSizeString().width, height: 40)
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
