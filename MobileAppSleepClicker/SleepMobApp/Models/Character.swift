
//
//  Сharacter.swift
//  MobileApp_Sleep
//
//  Created by Наталья Захарова on 27.02.2024.
//
import UIKit

enum SleepState {
    case asleep, awake
    
    var next: SleepState {
        switch self {
        case .asleep:
            return .awake
        case .awake:
            return .asleep
        }
    }
}

final class Character {
    public var name: String
    public var hp: Int
    public var sleepiness: Int
    public var imageAwake: UIImage
    public var imageSleep: UIImage
    public var sleepState: SleepState
    
    

    init(name: String, imageAwake: UIImage, imageSleep: UIImage, sleepState: SleepState = SleepState.awake) {
        self.name = name
        self.imageAwake = imageAwake
        self.imageSleep = imageSleep
        self.sleepState = sleepState
        self.hp = 100
        self.sleepiness = 100
    }

    func toggleSleepState() {
           sleepState = sleepState.next
       }
}

