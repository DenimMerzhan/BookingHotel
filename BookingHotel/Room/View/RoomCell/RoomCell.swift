//
//  RoomCellCollectionViewCell.swift
//  BookingHotel
//
//  Created by Деним Мержан on 06.09.23.
//

import UIKit

class RoomCell: UICollectionViewCell {

    
    @IBOutlet weak var pageCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var descriptionNumber: UILabel!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pageCollectionView.reloadData()
        tagCollectionView.reloadData()
    }
    
    @IBAction func pageControllTapped(_ sender: UIPageControl) {
        let page = sender.currentPage
        print(pageCollectionView.numberOfItems(inSection: 0))
        if page < pageCollectionView.numberOfItems(inSection: 0) {
            pageCollectionView.scrollToItem(at: IndexPath(row: page, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
}


extension RoomCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let room = room else {return 0}
        if collectionView == pageCollectionView {
            return room.roomImage.count
        }else {
            return room.peculiarities.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let room = room else {return UICollectionViewCell()}
        if collectionView == pageCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SwipeCell", for: indexPath) as! SwipeCell
            if let image = room.roomImage[indexPath.row] {
                cell.image.image = image
                cell.image.hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(0.5))
            }

            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
            if let room = self.room {
                cell.descriptionText.text = room.peculiarities[indexPath.row]
                if indexPath.row == room.peculiarities.count - 1 {
                    cell.button.isHidden = false
                    cell.descriptionText.textColor = UIColor(named: "ButtonColor")
                    cell.backView.backgroundColor = UIColor(named: "LastTagColor")
                }
            }
            return cell
        }
 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == pageCollectionView {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }else {
            guard let tagArr = room?.peculiarities else {return .zero}
            var cellWidth = tagArr[indexPath.row].contentSizeString(font: K.font.tagCell).width + 20
            
            if indexPath.row == tagArr.count - 1 {
                cellWidth += 25 /// 20 размер кнопки, 5 расстояние внутри стэка
            }
            if cellWidth > collectionView.frame.width {
                cellWidth = collectionView.frame.width
            }
           
            return CGSize(width: cellWidth, height: 45)
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
