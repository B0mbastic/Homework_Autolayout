//
//  ViewController.swift
//  Homework_Autolayout
//
//  Created by Александр Ковбасин on 12.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var FirstLabel: UILabel = {
        let FirstLabel = UILabel()
        FirstLabel.translatesAutoresizingMaskIntoConstraints = false
        FirstLabel.backgroundColor = .green
        FirstLabel.text = "First label additional long content" // Проверка длинного содержимого
        FirstLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal) // Приоритет растягивания содержимого
        return FirstLabel
    }()
    
    private lazy var SecondLabel: UILabel = {
        let SecondLabel = UILabel()
        SecondLabel.translatesAutoresizingMaskIntoConstraints = false
        SecondLabel.backgroundColor = .orange
        SecondLabel.text = "Second label additional long content" // Проверка длинного содержимого
        SecondLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal) // Приоритет растягивания содержимого
        return SecondLabel
    }()
    
    private lazy var ImageView: UIImageView = {
        let ImageView = UIImageView()
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.backgroundColor = .red
        return ImageView
    }()
    
    // массив констрейнтов для альбомной ориентации
    private var wideConstraints: [NSLayoutConstraint] = []

    // массив констрейнтов для портретной ориентации
    private var narrowConstraints: [NSLayoutConstraint] = []
    
    //  массив констрейнтов одинаковых для обеих ориентаций (не стал задавать)
    //private var commonConstraints: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(FirstLabel)
        view.addSubview(SecondLabel)
        view.addSubview(ImageView)
        
        narrowConstraints = [
            FirstLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            FirstLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
        
            SecondLabel.leadingAnchor.constraint(equalTo: FirstLabel.trailingAnchor, constant: 8),
            SecondLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            SecondLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            
            ImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ImageView.topAnchor.constraint(lessThanOrEqualTo: FirstLabel.bottomAnchor, constant: 10),
            ImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.height/10),
            ImageView.widthAnchor.constraint(equalTo: ImageView.heightAnchor, multiplier: 1)
        ]
        
        wideConstraints = [
            FirstLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            FirstLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        
            SecondLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            SecondLabel.leadingAnchor.constraint(equalTo: FirstLabel.trailingAnchor, constant: 20),
            
            ImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ImageView.leadingAnchor.constraint(equalTo: SecondLabel.trailingAnchor, constant: 20),
            ImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            //ImageView.widthAnchor.constraint(equalToConstant: 50),
            ImageView.heightAnchor.constraint(equalTo: ImageView.widthAnchor, multiplier: 1)
        ]
        // активируем общие констрейнты если надо (не стал активировать)
        //NSLayoutConstraint.activate(commonConstraints)
        
        if view.frame.width > view.frame.height {
            // проверка на альбомный режим
            NSLayoutConstraint.activate(wideConstraints)
        } else {
            // проверка на портретный режим
            NSLayoutConstraint.activate(narrowConstraints)
        }
        // Do any additional setup after loading the view.
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
            let isLandscape = UIDevice.current.orientation.isLandscape
            if isLandscape {
                // поворачиваем горизонтально и меняем констрейнты
                NSLayoutConstraint.deactivate(self.narrowConstraints)
                NSLayoutConstraint.activate(self.wideConstraints)
            } else {
                // поворачиваем вертикально и меняем констрейнты
                NSLayoutConstraint.deactivate(self.wideConstraints)
                NSLayoutConstraint.activate(self.narrowConstraints)
            }
        }
}

