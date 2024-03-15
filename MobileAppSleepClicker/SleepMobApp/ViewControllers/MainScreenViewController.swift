//
//  MainScreenViewController.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 13.03.2024.
//

import UIKit

final class MainScreenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    static var balance = 0
    
 
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let heroCell = heroes.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HeroCell
        if(heroCell.hero.sleepState == SleepState.awake) {
            heroCell.heroImageView.image = heroCell.hero.imageAwake
        } else {
            heroCell.heroImageView.image = heroCell.hero.imageSleep
        }
        heroCell.heroNameLabel.text = heroCell.hero.name
        heroCell.heroHPLabel.text = heroCell.hero.hp.formatted()
        heroCell.heroSleepinessLabel.text = heroCell.hero.sleepiness.formatted()
        heroCell.backgroundColor = .white
        if let cell = collectionView.cellForItem(at: indexPath) as? HeroCell {
              // Переключаем состояние сна персонажа
              cell.hero.toggleSleepState()
              
              // Обновляем UI ячейки
              cell.updateUI()
          }
        
     
        return heroCell
    }
    
 
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           
            guard let cell = collectionView.cellForItem(at: indexPath) as? HeroCell else { return }

             
                    let hero = cell.hero
                    hero.toggleSleepState()
                    
                  
                    cell.heroImageView.image = hero.sleepState == .awake ? hero.imageAwake : hero.imageSleep
                
                    MainScreenViewController.balance += 1
                    MainScreenViewController.balanceLabel.text = "\(MainScreenViewController.balance)"
        }
    

    
    private let titleLabel = UILabel()
    private let settingsButton = UIButton()
    private let balanceIconImageView = UIImageView()
    static let balanceLabel = UILabel()
    private let balanceStackView = UIStackView()
    
    private let cellId = "hero"
    private var heroes: UICollectionView!
    
    func configureUI(){
        view.addSubview(titleLabel)
        view.addSubview(settingsButton)
        view.addSubview(MainScreenViewController.balanceLabel)
        configureTitleLable()
        configureSettingsButton()
        configureHeroes()
        configureBalanceLabel()
    }
    
    func configureBalanceStackView() {
        // Настройка иконки баланса
        balanceIconImageView.image = UIImage(named: "balance")
        balanceIconImageView.setWidth(100)
        balanceIconImageView.setHeight(70)

        // Настройка лейбла баланса
        MainScreenViewController.balanceLabel.text = " \(MainScreenViewController.balance)"
        MainScreenViewController.balanceLabel.textColor = .white

        // Настройка стека
        balanceStackView.axis = .horizontal
        balanceStackView.alignment = .center
        balanceStackView.distribution = .fillProportionally
        balanceStackView.spacing = 8 // Расстояние между элементами

        // Добавление элементов в стек
        balanceStackView.addArrangedSubview(balanceIconImageView)
        balanceStackView.addArrangedSubview(MainScreenViewController.balanceLabel)

        balanceStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(balanceStackView)

        // Констрейнты для стека
        NSLayoutConstraint.activate([
            balanceStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            balanceStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            balanceIconImageView.heightAnchor.constraint(equalToConstant: 100), // Высота иконки
            balanceIconImageView.widthAnchor.constraint(equalToConstant: 100) // Ширина иконки
        ])
    }
    
    func configureTitleLable() {
        // Настройка titleLabel
        titleLabel.text = "World of Sweet Dreams"
        titleLabel.font = UIFont.systemFont(ofSize: 25)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.pinCenterX(to: view)
        titleLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 15)
        
    }
    
    func configureBalanceLabel() {
        MainScreenViewController.balanceLabel.text = "\(MainScreenViewController.balance)"
        MainScreenViewController.balanceLabel.textColor = .white
        MainScreenViewController.balanceLabel.pinCenterX(to: view.centerXAnchor)
        MainScreenViewController.balanceLabel.pinTop(to: titleLabel.bottomAnchor, 10)
    }
    
    func configureSettingsButton() {
        // Настройка settingsButton
        settingsButton.setImage(UIImage(named: "settingsIcon"), for: .normal)
        settingsButton.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        settingsButton.pinLeft(to: titleLabel.trailingAnchor, 30)
        settingsButton.pinCenterY(to: titleLabel.centerYAnchor)
    }
    @objc
    private func goToSettings() {
        if let navigationController = self.navigationController {
            // Создаем экземпляр SettingsViewController
            let settingsVC = SettingsViewController()

            navigationController.pushViewController(settingsVC, animated: true)
        } else {
         
            let settingsVC = SettingsViewController()
         
            settingsVC.modalPresentationStyle = .fullScreen
            self.present(settingsVC, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         configureUI()
         view.backgroundColor = UIColor(hex: "0D4496")
         configureBalanceStackView()
         heroes.delegate = self
         heroes.dataSource = self
        
    }
    
    private func configureHeroes() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 45
        layout.sectionInset = UIEdgeInsets(top: 45, left: 22, bottom: 25, right: 22)
        layout.itemSize = CGSize(width: (view.frame.width-60)/2, height: view.frame.height/4)
        let rect = CGRect(x: 0, y: 190, width: view.frame.width, height: view.frame.height - 285)
        heroes = UICollectionView(frame: rect, collectionViewLayout: layout)
        heroes.dataSource = self
        heroes.delegate = self
        heroes.register(HeroCell.self, forCellWithReuseIdentifier: cellId)
        heroes.showsVerticalScrollIndicator = true
        heroes.backgroundColor = .clear
        heroes.layer.masksToBounds = true
        view.addSubview(heroes)
    }
    
}
func scheduleLocalNotification() {
      let content = UNMutableNotificationContent()
      content.title = "Время действовать!"
      content.body = "Пора вернуться в приложение."
      content.sound = .default

      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false) // Здесь 5 секунд для примера

      let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

      UNUserNotificationCenter.current().add(request) { error in
          if let error = error {
              print("Ошибка при добавлении уведомления: \(error.localizedDescription)")
          }
      }
  }
extension UIColor {
    static let customPurple = UIColor(hex: "4A40BB")
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}
