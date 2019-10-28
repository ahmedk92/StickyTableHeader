//
//  ViewController.swift
//  TableHeader
//
//  Created by Ahmed Khalaf on 9/26/19.
//  Copyright © 2019 Ahmed Khalaf. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    lazy var label: UILabel = {
        let l = UILabel(frame: .zero)
        l.textAlignment = .center
        contentView.addSubview(l)
        return l
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .lightGray
        label.sizeToFit()
        label.center = contentView.center
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
        cell.label.text = "\(indexPath.row)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.height * 2, height: collectionView.bounds.height)
    }
    
    private lazy var categoriesHeader: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.register(CollectionCell.self, forCellWithReuseIdentifier: "cell")
        cv.dataSource = self
        return cv
    }()
    
    @IBOutlet weak var tableView: TableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.stickyHeaderView = categoriesHeader
        tableView.addSubview(categoriesHeader)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return nil
        } else {
            return "Section \(section)"
        }
    }
}

class TableView: UITableView {
    weak var stickyHeaderView: UIView?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let stickyHeaderView = stickyHeaderView, let tableHeaderView = tableHeaderView {
            
            stickyHeaderView.frame = CGRect(x: 0, y: max(tableHeaderView.frame.maxY, contentOffset.y), width: tableHeaderView.frame.width, height: 50)
            bringSubviewToFront(stickyHeaderView)
        }
    }
}
