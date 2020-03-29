//
//  SentMemesCollectionViewController.swift
//  Project 02 MemeMe 1.0
//
//  Created by Brandan McDevitt on 29/03/2020.
//  Copyright © 2020 Brandan McDevitt. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    private let reuseIdentifier = "Cell"
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    private let labelAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 20)!,
        NSAttributedString.Key.strokeWidth: -3.5
    ]
    
    private let notificationName = Notification.Name("SentMeme")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: notificationName, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource


    @objc func reload() {
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SentMemesCollectionViewCell
    
        cell.memeImage?.image = memes[indexPath.row].originalImage
        cell.topText?.attributedText = NSAttributedString(string: memes[indexPath.row].topText, attributes: labelAttributes)
        cell.bottomText?.attributedText = NSAttributedString(string: memes[indexPath.row].bottomText, attributes: labelAttributes)

        updateLabels(labels: [cell.topText, cell.bottomText])
        
        return cell
    }
    
    private func updateLabels(labels: [UILabel]) {
        labels.forEach {
            $0.sizeToFit()
        }
    }
}
