//
//  SchoolDetailViewController.swift
//  SchoolNYC
//
//  Created by YASIN on 7.03.2023.
//

import UIKit
import PureLayout

class SchoolDetailViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    var detailViewModel: SchoolDetailViewModel?
    private let sectionList: [String] = ["School Detail", "SAT", "School Map"]
    
    private struct Constants {
        static let identifier = "detailIdentifier"
        static let headerIdentifier = "detailHeaderIdentifier"
        static let satIdentifier = "satIdentifier"
        static let mapIdentifier = "mapIdentifier"
        
        static let cellHeight = 380.0
        static let headerHeight = 50.0
        static let satCellHeight = 200.0
        static let mappCellHeight = 250.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        title = detailViewModel?.school.schoolName ?? "school name"
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.size.width, height: Constants.cellHeight)
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: view.frame.size.width, height: Constants.headerHeight)
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else {
            return
        }
        
        view.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges()
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(SchoolDetailCollectionViewCell.self, forCellWithReuseIdentifier: Constants.identifier)
        collectionView.register(SATDetailCollectionViewCell.self, forCellWithReuseIdentifier: Constants.satIdentifier)
        collectionView.register(SchoolDetailMapCollectionViewCell.self, forCellWithReuseIdentifier: Constants.mapIdentifier)
        collectionView.register(SchoolSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.headerIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}


extension SchoolDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.identifier, for: indexPath)
            guard let schoolDetailCell = cell as? SchoolDetailCollectionViewCell,
                  let school = detailViewModel?.school else {
                return cell
            }
            schoolDetailCell.update(school: school)
            
            return schoolDetailCell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.satIdentifier, for: indexPath)
            guard let satcell = cell as? SATDetailCollectionViewCell,
                  let sat = detailViewModel?.schoolSAT else {
                return cell
            }
            satcell.update(sat: sat)
            
            return satcell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.mapIdentifier, for: indexPath)
            guard let mapCell = cell as? SchoolDetailMapCollectionViewCell,
                  let school = detailViewModel?.school else {
                return cell
            }
            mapCell.populate(school: school)
            
            return mapCell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader,
           let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.headerIdentifier, for: indexPath) as? SchoolSectionHeader {
            sectionHeader.headerLabel.text = sectionList[indexPath.section]
            return sectionHeader
        }
        return UICollectionReusableView()
    }
}

extension SchoolDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.bounds.width, height: Constants.cellHeight)
        case 1:
            return CGSize(width: collectionView.bounds.width, height: Constants.satCellHeight)
        default:
            return CGSize(width: collectionView.bounds.width, height: Constants.mappCellHeight)
        }
    }
}

extension SchoolDetailViewController: UICollectionViewDelegate {
    
}
