//
//  ViewController.swift
//  SimpleWeatherApp
//
//  Created by Jang Seok jin on 2021/08/08.
//

import UIKit

class MainViewController: UIViewController {

    lazy var collectionView = UICollectionView()
    var currentWeather: CurrentWeatherCollectionViewCell?
    let flowlayout = UICollectionViewFlowLayout()
    let textfield = UITextField()
    let searchImage = UIImageView()
    var cityName: String = ""
    var weatherResponse: WeatherResponse? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        setUI()
        fetchData()
    }

    func fetchData() {
        NetworkManager.shared.getDustData(cityName: "Incheon") { res in
            switch res {
            case .success(let weather):
                print(weather)
                self.weatherResponse = weather
            case .failure(let error):
                print(error)
            case .none:
                print("none")
            }
        }
    }
    
    func setUI() {
        flowlayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        collectionView.frame = CGRect(x: view.frame.minX,
                                      y: view.frame.minY + 120,
                                      width: view.frame.size.width,
                                      height: view.frame.size.height)
        collectionView.backgroundColor = .systemTeal
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CurrentWeatherCollectionViewCell.self, forCellWithReuseIdentifier: CurrentWeatherCollectionViewCell.identifier)
        view.addSubview(collectionView)
        
        view.addSubview(searchImage)
        searchImage.image = UIImage(systemName: "magnifyingglass")
        searchImage.contentMode = .scaleAspectFit
        searchImage.tintColor = .white
        searchImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
            make.leading.equalTo(view.snp.leading).offset(-5)
            make.bottom.equalTo(collectionView.snp.top).offset(-20)
            make.width.equalTo(view.frame.size.width * 0.2)
        }
        
        view.addSubview(textfield)
        textfield.delegate = self
        textfield.placeholder = "Please enter the cityname"
        textfield.borderStyle = .roundedRect
        textfield.snp.makeConstraints { make in
            make.top.equalTo(searchImage.snp.top)
            make.leading.equalTo(searchImage.snp.trailing)
            make.bottom.equalTo(searchImage.snp.bottom)
            make.width.equalTo(view.frame.size.width * 0.75)
        }
    }
}

//MARK: - TextFieldDelegate
extension MainViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textfield.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textfield.resignFirstResponder()
        guard let currentString = textfield.text else { return true }
        NetworkManager.shared.getDustData(cityName: currentString) { res in
            switch res {
            case .success(let weather):
                self.weatherResponse = weather
            case .failure(let error):
                print(error)
            case .none:
                print("none")
            }
        }
        currentWeather?.cityNameLabel.text = currentString
        return true
    }
}

//MARK: - CollectionViewDelegate, CollectionViewDataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentWeatherCollectionViewCell.identifier, for: indexPath) as! CurrentWeatherCollectionViewCell
        
        guard let weatherResponse = weatherResponse else { return cell}
        
        cell.cityNameLabel.text = "\(weatherResponse.name)"
        cell.weatherLabel.text = "\(weatherResponse.weather[indexPath.row].main)"
        cell.tempLabel.text = "\(Int(temperatureInFahrenheit(temperature: weatherResponse.main.temp)))°"
        cell.tempRangeLabel.text = "\(Int(temperatureInFahrenheit(temperature: weatherResponse.main.temp_min)))°/ \(Int(temperatureInFahrenheit(temperature: weatherResponse.main.temp_max)))°"
        
        if cell.weatherLabel.text == "Clouds" {
            cell.weatherImage.image = UIImage(named: "Clouds")
            cell.backgroundColor = .systemBlue
        }else if cell.weatherLabel.text == "Sunny" {
            cell.weatherImage.image = UIImage(named: "Sunny")
            cell.backgroundColor = .yellow
        }else if cell.weatherLabel.text == "Clear" {
            cell.weatherImage.image = UIImage(named: "Clear")
            cell.backgroundColor = .systemRed
        }else {
            cell.weatherImage.image = UIImage(named: "Rainy")
            cell.backgroundColor = .lightGray
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width * 0.95, height: view.frame.size.height / 2.7)
    }
}

