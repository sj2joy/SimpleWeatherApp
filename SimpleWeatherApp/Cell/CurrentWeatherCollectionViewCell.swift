//
//  CurrentWeatherCollectionViewCell.swift
//  SimpleWeatherApp
//
//  Created by Jang Seok jin on 2021/08/09.
//

import UIKit
import SnapKit

class CurrentWeatherCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CurrentWeatherCollectionViewCell"
    let tempLabel = UILabel()
    let weatherLabel = UILabel()
    let tempRangeLabel = UILabel()
    let weatherImage = UIImageView()
    var cityNameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func setUI() {
        self.layer.cornerRadius = 40
        self.backgroundColor = .systemTeal
        
        contentView.addSubview(tempLabel)
        tempLabel.textColor = .white
        tempLabel.font = UIFont(name: "Arial", size: 50)
        tempLabel.numberOfLines = 0
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.leading.equalTo(20)
            make.height.equalTo(self.frame.size.height / 2.5)
            make.width.equalTo(self.frame.size.width / 2.5)
        }
        
        contentView.addSubview(cityNameLabel)
        cityNameLabel.font = UIFont(name: "Arial", size: 40)
        cityNameLabel.textColor = .white
        cityNameLabel.numberOfLines = 0
        cityNameLabel.textAlignment = .center
        cityNameLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.top)
            make.trailing.equalTo(-20)
            make.width.equalTo(self.frame.size.width / 2.5)
            make.height.equalTo(self.frame.size.height / 2.5)
        }
        
        contentView.addSubview(weatherLabel)
        weatherLabel.textColor = .white
        weatherLabel.font = UIFont(name: "Arial", size: 30)
        weatherLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom)
            make.left.equalTo(20)
            make.height.equalTo(self.frame.size.height / 5)
            make.width.equalTo(self.frame.size.width / 3)
        }
        
        contentView.addSubview(tempRangeLabel)
        tempRangeLabel.textColor = .white
        tempRangeLabel.font = UIFont(name: "Arial", size: 25)
        tempRangeLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherLabel.snp.bottom)
            make.left.equalTo(20)
            make.height.equalTo(self.frame.size.height / 5)
            make.width.equalTo(self.frame.size.width / 2.5)
        }
        
        contentView.addSubview(weatherImage)
        weatherImage.contentMode = .scaleAspectFill
        weatherImage.snp.makeConstraints { make in
            make.top.equalTo(cityNameLabel.snp.bottom)
            make.trailing.equalTo(-20)
            make.height.equalTo(self.frame.size.height / 4)
            make.width.equalTo(self.frame.size.width / 2.5)
        }
    }
}
