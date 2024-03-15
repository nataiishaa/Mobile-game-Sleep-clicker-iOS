//
//  AboutDevController.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 13.03.2024.
//

import UIKit 
import MapKit

final class AboutDevController: UIViewController {
    private let titleLabel = UILabel()
    private let nameLabel = UILabel() // Лейбл для имени
    private let contactLabel = UILabel() // Лейбл для Telegram ника
    private let officeLabel = UILabel()
    private let officeAddress = UILabel()
    private let mapView = MKMapView() // Карта для отображения местоположения
    private let pillow = UIImageView(image: UIImage(named: "pillow"))
    
    func configureUI(){
        view.addSubview(pillow)
        view.addSubview(titleLabel)
        view.addSubview(nameLabel)
        view.addSubview(contactLabel)
        view.addSubview(officeLabel)
        view.addSubview(officeAddress)
        view.addSubview(mapView)
        
        configurePillow()
        configureName()
        configureContact()
        configureTitleLable()
        configureOfficeLabel()
        configureOfficeAddress()
        configureBackButton()
        configureMapView()
        
        
    }
    
    private func configurePillow() {
        pillow.pinLeft(to: view.leadingAnchor, -10)
        pillow.setWidth(500)
        pillow.setHeight(500)
        pillow.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
    }
    
    private func configureName(){
        nameLabel.text = "HSE Student: Nataly Zakharova"
        nameLabel.textColor = .black
        nameLabel.pinTop(to: pillow.topAnchor, 170)
        nameLabel.pinCenterX(to: view.centerXAnchor)
    }
    
    private func configureContact(){
        contactLabel.text = "Telegram: @nataishaa"
        contactLabel.pinTop(to: nameLabel.bottomAnchor, 10)
        contactLabel.pinCenterX(to: view.centerXAnchor)
    }
    
    private func configureOfficeLabel() {
        officeLabel.text = "Office: HSE University"
        officeLabel.pinTop(to: contactLabel.bottomAnchor, 10)
        officeLabel.pinCenterX(to: view.centerXAnchor)
    }
    
    private func configureOfficeAddress() {
        officeAddress.text = "Moscow, Pokrovsky blvd, 11"
        officeAddress.pinTop(to: officeLabel.bottomAnchor, 10)
        officeAddress.pinCenterX(to: view.centerXAnchor)
    }
    
    private func configureTitleLable() {
        // Настройка titleLabel
        titleLabel.text = "About developer"
        titleLabel.font = UIFont.systemFont(ofSize: 30)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.pinCenterX(to: view)
        titleLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 5)
        
      
    }
    
    
    @objc
    func backAction() {
       
        if let navController = navigationController, navController.viewControllers.first != self {
            navController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    private func configureBackButton() {
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "back"), for: .normal)
        //backButton.setTitle("Back", for: .normal)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)

        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        

        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor), // Отступ сверху от safe area
            backButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20), // Отступ справа от safe area
            backButton.widthAnchor.constraint(equalToConstant: 60), // Ширина кнопки
            backButton.heightAnchor.constraint(equalToConstant: 40) // Высота кнопки
        ])
    }
    override func viewDidLoad() {
        configureUI()
        self.view.backgroundColor = UIColor(hex: "0D4496") // Цвет фона
       
    }
   
    private func configureMapView() {
        
        let locationCoordinate = CLLocationCoordinate2D(latitude: 55.754471, longitude: 37.649139)

      
        let region = MKCoordinateRegion(center: locationCoordinate, latitudinalMeters: 500, longitudinalMeters: 500) // 500 метров вокруг интересующей точки
        mapView.setRegion(region, animated: true)

        // Аннотацию для этого местоположения
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinate
        annotation.title = "Pokrovsky Boulevard, 11" //
        annotation.subtitle = "Office"
        mapView.addAnnotation(annotation)

        mapView.pinTop(to: pillow.bottomAnchor,-50)
        mapView.pinCenterX(to: view.centerXAnchor)
        mapView.setWidth(360)
        mapView.setHeight(250)
    }
    
    
    
}
