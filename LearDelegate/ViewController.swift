//
//  ViewController.swift
//  LearDelegate
//
//  Created by Neal on 2020/1/13.
//  Copyright © 2020 neal812220. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let selectionView = SelectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectionView.dataSource = self
        
        selectionView.delegate = self
        
        setInfo()
        
        // Do any additional setup after loading the view.
    }
    
    func setInfo() {
        
        selectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(selectionView)
        
        NSLayoutConstraint.activate([
            selectionView.topAnchor.constraint(equalTo: view.topAnchor),
            selectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            selectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            selectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
}

extension ViewController: SelectionViewDataSource {
    
    func selectionViewOptionsFont(_ selectionView: SelectionView, option: Int, currentView: Int) -> String {
        if currentView == 0 && option == 0 {
            return "Red"
        } else if currentView == 0 && option == 1 {
            return "Yellow"
        } else if currentView == 1 && option == 0 {
            return "Red"
        } else if currentView == 1 && option == 1 {
            return "Yellow"
        } else {
            return "Blue"
        }
    }
    
    func selectionViewOptions(_ selectionView: SelectionView, currentView: Int) -> Int {
        
        if currentView == 0 {
            return 2
        } else {
            return 3
        }
        
    }
    
    func selectionViewOptionFontColor(_ selectionView: SelectionView) -> UIColor {
        return UIColor.white
    }
}
extension ViewController: SelectionViewDelegate {
    
    func canSelectOption(_ selectionView: SelectionView, index: Int, currentView: Int) {
        if currentView == 0 && index == 1 {
            selectionView.optionisEnable = false
        } else {
            selectionView.optionisEnable = true
        }
    }
    
    
    func selectOption(_ selectionView: SelectionView, at index: Int, currentView: Int) {
        
        if currentView == 0 && index == 0 {
            selectionView.topView.backgroundColor = .red
        } else if currentView == 0 && index == 1 {
            selectionView.topView.backgroundColor = .yellow
        } else if currentView == 1 && index == 0 {
            selectionView.bottomView.backgroundColor = .red
        } else if currentView == 1 && index == 1 {
            selectionView.bottomView.backgroundColor = .yellow
        } else {
            selectionView.bottomView.backgroundColor = .blue
        }
    }
    
    
}


