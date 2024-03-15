//
//  CloudStack.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 13.03.2024.
//

import UIKit

final class CloudStack : UIView {
    let soundCloud = CloudButton(title: "sound")
    let notificationCloud = CloudButton(title: "notification")
    let infoClous = CloudButton(title: "about dev")
    
    
    let CloudStack = UIStackView()
    
    override init (frame: CGRect) {
        super.init(frame:frame)
        addSubview(CloudStack)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        CloudStack.translatesAutoresizingMaskIntoConstraints = false
        CloudStack.axis = .vertical
        CloudStack.spacing = 12
        CloudStack.clipsToBounds = true
        
        for cloud in [soundCloud,notificationCloud,infoClous]{
            CloudStack.addArrangedSubview(cloud)
        }
        
    }
}
