//
//  ViewController.swift
//  Interview
//
//  Created by Rangel Cardoso Dias on 01/08/24.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: -> View
    lazy var collectionView: UICollectionView = {
        let c = UICollectionView(frame: .zero, collectionViewLayout: createFlowLayout())
        c.translatesAutoresizingMaskIntoConstraints = false
        c.backgroundColor = .white

        return c
    }()
    
    var timer: Timer?
    var currentCellIndex = 0
    var currentTime = 0
    let numberOfItems = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        populateView()
    }

    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        return layout
    }
    
    private func setupView() {
        setupHierachy()
        addtionalSetup()
    }
    
    private func setupHierachy() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func addtionalSetup() {
        collectionView.collectionViewLayout = createFlowLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(TimerCell.self,
                                forCellWithReuseIdentifier: TimerCell.resuableCellIdentifier)
    }
    
    private func populateView() {
        collectionView.reloadData()
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }

    @objc func updateTimer() {
        if currentTime >= (10 * (currentCellIndex+1)) {
            currentCellIndex += 1

            if currentCellIndex >= numberOfItems {
                timer?.invalidate()
                return
            }
        }
        
        currentTime += 1
        
        let indexPath = IndexPath(item: currentCellIndex, section: 0)
        
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: indexPath,
                                             at: .centeredVertically,
                                             animated: true)
            if let cell = self.collectionView.cellForItem(at: indexPath) as? TimerCell {
                cell.config(with: String(self.currentTime))
            }
        }
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 2
        let numberOfItemPerColumn: CGFloat = 5
        let spacingBetweenItems: CGFloat = 10
        
        let totalWidthSpacing = (3 * spacingBetweenItems) + ((numberOfItemsPerRow - 1) * spacingBetweenItems)
        let width = (collectionView.bounds.width - totalWidthSpacing) / numberOfItemsPerRow
        
        let totalHeightSpacing = (6 * spacingBetweenItems) + ((numberOfItemPerColumn - 1) * spacingBetweenItems)
        let height = (collectionView.bounds.height - totalHeightSpacing) / numberOfItemPerColumn
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10, left: 10, bottom: 10, right: 10)
    }
}


extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimerCell.resuableCellIdentifier, for: indexPath)
        
        return cell
    }
}
