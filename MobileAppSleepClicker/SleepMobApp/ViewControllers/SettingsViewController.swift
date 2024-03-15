//
//  SettingsViewController.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 13.03.2024.
//


import UIKit


final class SettingsViewController: UIViewController {
    private let titleLabel = UILabel()
    private let  clouds = CloudStack()
    private let ringSounds = UIImageView(image:UIImage(named: "soundActive"))
    private let ringNotification = UIImageView(image:UIImage(named: "soundActive"))
    private var soundOn = true
    private var notificationOn = true
    
    func configureUI(){
        view.addSubview(titleLabel)
        view.addSubview(clouds)
        view.addSubview(ringSounds)
        view.addSubview(ringNotification)
        configureTitleLable()
        configureBackButton()
        clouds.setWidth(390)
        clouds.setHeight(546)
        clouds.pinTop(to: titleLabel.bottomAnchor, 50)
        clouds.pinCenterX(to: view)
        clouds.soundCloud.addTarget(self, action: #selector(changeSound), for: .touchUpInside)
        clouds.notificationCloud.addTarget(self, action: #selector(changeNotifications), for: .touchUpInside)
        clouds.infoClous.addTarget(self, action: #selector(goToInfo), for: .touchUpInside)
        ringSounds.pinTop(to: clouds.topAnchor,10)
        ringSounds.pinCenterX(to: view,7)
        
    
        ringNotification.pinCenterX(to: view,7)
        ringNotification.pinCenterY(to: view.centerYAnchor,-10)
        
        
        
        
    }
    
    @objc
    private func changeSound() {
    
          MusicPlayer.shared.toggleMusic()
          ringSounds.image = MusicPlayer.shared.isMusicPlaying() ? UIImage(named: "soundActive") : UIImage(named: "soundInactive")
    }
    
//    @objc private func changeNotifications() {
//        if (notificationOn) {
//            ringNotification.image = UIImage(named:"soundInactive")
//            notificationOn = false
//        }
//        else{
//            ringNotification.image = UIImage(named:"soundActive")
//            notificationOn = true
//            
//        }
//        
//    }
    @objc private func changeNotifications() {
        notificationOn.toggle()
        
        if notificationOn {
            scheduleNotification()
        } else {
            cancelAllNotifications()
        }
        
        // Обновление изображения
        ringNotification.image = notificationOn ? UIImage(named: "soundActive") : UIImage(named: "soundInactive")
    }

    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Напоминание"
        content.body = "Не забудьте проверить наше приложение сегодня!"
        content.sound = UNNotificationSound.default

        // Например, через 10 секунд после нажатия
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)

        let request = UNNotificationRequest(identifier: "notification.id.01", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Ошибка при добавлении уведомления: \(error.localizedDescription)")
            }
        }
    }

    func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    
    @objc private func goToInfo() {
        
    }
    
    
    override func viewDidLoad() {
        configureUI()
        self.view.backgroundColor = UIColor(hex: "0D4496") // Цвет фона
       
    }
    
    private func configureTitleLable() {
        // Настройка titleLabel
        titleLabel.text = "Settings"
        titleLabel.font = UIFont.systemFont(ofSize: 50)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.pinCenterX(to: view)
        titleLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 20)
        
        clouds.infoClous.addTarget(self, action: #selector(goToAboutDev), for: .touchUpInside)
    }
    
    private func configureBackButton() {
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "back"), for: .normal)
        //backButton.setTitle("Back", for: .normal)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)

        // Добавляем кнопку на view и отключаем autoresizing mask
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
       
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor), // Отступ сверху от safe area
            backButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20), // Отступ справа от safe area
            backButton.widthAnchor.constraint(equalToConstant: 60), // Ширина кнопки
            backButton.heightAnchor.constraint(equalToConstant: 40) // Высота кнопки
        ])
    }
    
    @objc
    func backAction() {
       
        if let navController = navigationController, navController.viewControllers.first != self {
            navController.popViewController(animated: true)
        } else {
    
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    @objc
    private func goToAboutDev() {
        if let navigationController = self.navigationController {

            let aboutDevVC = AboutDevController()
 
            navigationController.pushViewController(aboutDevVC, animated: true)
        } else {
         
            let aboutDevVC = AboutDevController()
           
            aboutDevVC.modalPresentationStyle = .fullScreen
            self.present(aboutDevVC, animated: true, completion: nil)
        }
        
    }
    
 
    
    
}
