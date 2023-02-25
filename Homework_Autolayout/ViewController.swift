//
//  ViewController.swift
//  Homework_Autolayout
//
//  Created by Александр Ковбасин on 12.02.2023.
//

import UIKit
import SnapKit

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
    
    // массив констрейнтов одинаковых для обеих ориентаций (не стал задавать)
    //private var commonConstraints: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func addConstraints(orientation: String) -> Void {
        switch orientation {
        case "portrait":
            FirstLabel.snp.remakeConstraints { make in
                make.leading.equalToSuperview().inset(16)
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            }
            SecondLabel.snp.remakeConstraints { make in
                make.leading.equalTo(FirstLabel.snp.trailing).offset(16)
                make.trailing.equalToSuperview().inset(16)
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(30)
            }
            ImageView.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.lessThanOrEqualTo(FirstLabel.snp.bottom).offset(10)
                make.bottom.equalTo(view.snp.centerY).offset(-0.1*view.frame.height)
                make.width.equalTo(ImageView.snp.height)
            }
        case "landscape":
            FirstLabel.snp.remakeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalToSuperview().inset(20)
            }
            SecondLabel.snp.remakeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalTo(FirstLabel.snp.trailing).offset(20)
            }
            ImageView.snp.remakeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalTo(SecondLabel.snp.trailing).offset(20)
                make.trailing.equalToSuperview().inset(20)
                make.height.equalTo(ImageView.snp.width)
            }
        default:
            print ("errror!")
        }
    }
    
    private func setupViews() {
        view.addSubview(FirstLabel)
        view.addSubview(SecondLabel)
        view.addSubview(ImageView)
        
        if view.frame.width > view.frame.height {
            // проверка на альбомный режим
            addConstraints(orientation: "landscape")
        } else {
            // проверка на портретный режим
            addConstraints(orientation: "portrait")
        }
        // Do any additional setup after loading the view.
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
            let isLandscape = UIDevice.current.orientation.isLandscape
            if isLandscape {
                // поворачиваем горизонтально и меняем констрейнты
                addConstraints(orientation: "landscape")
            } else {
                // поворачиваем вертикально и меняем констрейнты
                addConstraints(orientation: "portrait")
            }
        }
}

