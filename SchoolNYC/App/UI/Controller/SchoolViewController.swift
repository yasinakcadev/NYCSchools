//
//  ViewController.swift
//  SchoolNYC
//
//  Created by YASIN on 7.03.2023.
//

import UIKit
import Combine
import PureLayout
import MBProgressHUD

class SchoolViewController: UIViewController {
    
    private let viewModel = SchoolViewModel()
    private var cancelables = Set<AnyCancellable>()
    private var collectionView: UICollectionView?
    private var loadingHud: MBProgressHUD?
    
    private struct Constants {
        static let cellHeight =  120.0
        static let headerHeight = 50.0
        static let cellIdentifier = "cellIdentifier"
        static let headerIdentifier = "headerIdentifier"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupBinders()
        
        setupLodingHud()
        loadingHud?.show(animated: true)
        
        viewModel.getSchools()
        viewModel.getSchoolSats()
    }
    
    private func setupLodingHud() {
        guard let collectionView = collectionView else {
            return
        }
        loadingHud = MBProgressHUD.showAdded(to: collectionView, animated: true)
        loadingHud?.label.text = "Loading..."
        loadingHud?.detailsLabel.text = "Schools"
        loadingHud?.isUserInteractionEnabled = false
    }
    
    private func setupBinders() {
        viewModel.$error.receive(on: RunLoop.main)
            .sink { [weak self]error in
                if let _ = error {
                    self?.showErrorState()
                }
            }
            .store(in: &cancelables)
        
        viewModel.$schools.receive(on: RunLoop.main)
            .sink {[weak self] schools in
                if let _ = schools {
                    self?.loadingHud?.hide(animated: true)
                    self?.collectionView?.reloadData()
                    self?.removeStateView()
                    
                }else {
                    self?.showEmptyState()
                }
            }
            .store(in: &cancelables)
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
        collectionView.backgroundColor = .white
        collectionView.autoPinEdgesToSuperviewEdges()
        
        collectionView.register(SchoolListCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        collectionView.register(SchoolSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.headerIdentifier
        )
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

extension SchoolViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.schoolSectionList?[section].schools.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.schoolSectionList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? SchoolListCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let section = viewModel.schoolSectionList?[indexPath.section] {
            let school = section.schools[indexPath.item]
            cell.populate(school: school)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader,
           let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.headerIdentifier, for: indexPath) as? SchoolSectionHeader {
            sectionHeader.headerLabel.text = viewModel.schoolSectionList?[indexPath.section].city ?? "City"
            return sectionHeader
        }
        return UICollectionReusableView()
    }
}

extension SchoolViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let school = viewModel.schoolSectionList?[indexPath.section].schools[indexPath.item],
           let schoolSat = viewModel.satDictionary[school.dbn] {
            let detailViewController = SchoolDetailViewController()
            detailViewController.detailViewModel = SchoolDetailViewModel(school: school, schoolSAT: schoolSat)
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

extension SchoolViewController {
    func showErrorState() {
        let errorStateView = SchoolListStateView(forAutoLayout: ())
        errorStateView.update(for: .error)
        collectionView?.backgroundView = errorStateView
    }
    
    func removeStateView() {
        collectionView?.backgroundView = nil
    }
    
    func showEmptyState() {
        let stateView = SchoolListStateView(forAutoLayout: ())
        stateView.update(for: .empty)
        collectionView?.backgroundView = stateView
    }
}
