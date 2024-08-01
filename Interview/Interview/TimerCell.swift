//
//  TimmerCell.swift
//  Interview
//
//  Created by Rangel Cardoso Dias on 01/08/24.
//

import UIKit

class TimerCell: UICollectionViewCell {
    
    static let resuableCellIdentifier = String(describing: TimerCell.self)
    
    private (set) lazy var timerLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = .black
        l.font = UIFont.systemFont(ofSize: 24)
        l.text = "0.0"
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setupBackgroundColor()
    }
    
    func config(with timerStr: String) {
        self.timerLabel.text = timerStr
    }
    
    private func setupView() {
        contentView.addSubview(timerLabel)
        timerLabel.frame = contentView.bounds
        setupBackgroundColor()
    }
    
    private func setupBackgroundColor() {
        let colors: [UIColor] = [.blue,
                                 .orange,
                                 .cyan,
                                 .purple,
                                 .gray,
                                 .yellow]
        
        self.contentView.backgroundColor = colors.randomElement() ?? .blue
    }
}

