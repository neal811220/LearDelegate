//
//  SelectionView.swift
//  LearDelegate
//
//  Created by Neal on 2020/1/13.
//  Copyright © 2020 neal812220. All rights reserved.
//

import Foundation
import UIKit

protocol SelectionViewDataSource {
    
    func selectionViewOptions(_ selectionView: SelectionView, currentView: Int) -> Int
    
    func selectionViewOptionsFont(_ selectionView: SelectionView, option: Int, currentView: Int) -> String
    
    func inticatorViewBackgroundColor(_ selectionView: SelectionView, inticatorView: UIView) -> UIColor
    
    func selectionViewOptionFontColor(_ selectionView: SelectionView) -> UIColor
    
    func selectionViewOptionFontSize(_ selectionView: SelectionView) -> UIFont
}

extension SelectionViewDataSource {
    
    func selectionViewOptions(_ selectionView: SelectionView, currentView: Int) -> Int { return 2 }
    
    func inticatorViewBackgroundColor(_ selectionView: SelectionView, inticatorView: UIView) -> UIColor { return UIColor.blue }
    
    func selectionViewOptionFontColor(_ selectionView: SelectionView) -> UIColor { UIColor.white}
    
    func selectionViewOptionFontSize(_ selectionView: SelectionView) -> UIFont { return UIFont.systemFont(ofSize: 18) }
}

protocol SelectionViewDelegate {
    
    func selectOption(_ selectionView: SelectionView, at index: Int, currentView: Int)
    
    func canSelectOption(_ selectionView: SelectionView, index: Int, currentView: Int)
}

class SelectionView: UIView {
    
    var topbuttons = [UIButton]()
    
    var bottomButtons = [UIButton]()
    
    var delegate: SelectionViewDelegate?
    
    var topConstraint: NSLayoutConstraint?
    
    var bottomConstraint: NSLayoutConstraint?
    
    var optionisEnable = true
    
    var dataSource: SelectionViewDataSource? {
        didSet {
            setTopInfo()
            setbottomInfo()
        }
    }
    
    var topSelectionView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = NSLayoutConstraint.Axis.horizontal
        stack.distribution = UIStackView.Distribution.fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    
    var topindicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var bottomSelectionView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var topView: UIView = {
        let top = UIView()
        top.backgroundColor = .red
        top.translatesAutoresizingMaskIntoConstraints = false
        return top
    }()
    
    var bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var bottomindicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var bottomView: UIView = {
           let bottom = UIView()
           bottom.backgroundColor = .red
           bottom.translatesAutoresizingMaskIntoConstraints = false
           return bottom
       }()
    
    func setbottomInfo() {
        
        guard let dataSource = dataSource else { return }
        
        addSubview(bottomSelectionView)
        
        bottomSelectionView.addSubview(bottomStackView)
        
        for index in 0...(dataSource.selectionViewOptions(self, currentView: 1) - 1 ) {
            
            let button = UIButton()
            
            button.setTitle(dataSource.selectionViewOptionsFont(self, option: index, currentView: 1), for: .normal)
            
            button.setTitleColor(dataSource.selectionViewOptionFontColor(self), for: .normal)
            
            button.addTarget(self, action: #selector(selectbottomButton), for: .touchUpInside)
            
            button.tag = index
            
            bottomButtons.append(button)
            
            bottomStackView.addArrangedSubview(bottomButtons[index])
        }
        
        bottomSelectionView.addSubview(bottomindicatorView)
        
        bottomindicatorView.addSubview(bottomView)
        
        bottomView.backgroundColor = .blue
        
        bottomConstraint = bottomindicatorView.centerXAnchor.constraint(equalTo: bottomButtons[0].centerXAnchor)
        
        NSLayoutConstraint.activate([
            bottomSelectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomSelectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomSelectionView.rightAnchor.constraint(equalTo: rightAnchor),
            bottomSelectionView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.height / 4) * 2)
        ])
        
        NSLayoutConstraint.activate([
            bottomStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -400),
            bottomStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomStackView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bottomindicatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -375),
            bottomConstraint!,
            bottomindicatorView.widthAnchor.constraint(equalToConstant: 80),
            bottomindicatorView.heightAnchor.constraint(equalToConstant: 2)
        ])
        
        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -252),
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.rightAnchor.constraint(equalTo: rightAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
    }
    
    func setTopInfo() {
        
        guard let dataSource = dataSource else { return }
        
        addSubview(topSelectionView)
        
        topSelectionView.addSubview(stackView)
        
        for index in 0...(dataSource.selectionViewOptions(self, currentView: 0) - 1 ) {
            let button = UIButton()
            
            button.setTitle(dataSource.selectionViewOptionsFont(self, option: index, currentView: 0), for: .normal)
            
            button.setTitleColor(dataSource.selectionViewOptionFontColor(self), for: .normal)
            
            button.addTarget(self, action: #selector(selecttopButton), for: .touchUpInside)
            
            button.tag = index
            
            topbuttons.append(button)
            
            stackView.addArrangedSubview(topbuttons[index])
        }
        
        topSelectionView.addSubview(topindicatorView)
        
        topSelectionView.addSubview(topView)
        
        topView.backgroundColor = .red
        topConstraint = topindicatorView.centerXAnchor.constraint(equalTo: topbuttons[0].centerXAnchor)
        
        NSLayoutConstraint.activate([topSelectionView.topAnchor.constraint(equalTo: topAnchor), topSelectionView.leadingAnchor.constraint(equalTo: leadingAnchor), topSelectionView.rightAnchor.constraint(equalTo: rightAnchor), topSelectionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 3)])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            topindicatorView.topAnchor.constraint(equalTo: topAnchor, constant: 150),
            topindicatorView.widthAnchor.constraint(equalToConstant: 80),
            topConstraint!,
            topindicatorView.heightAnchor.constraint(equalToConstant: 2),
        ])
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: topAnchor, constant: 152),
            topView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topView.rightAnchor.constraint(equalTo: rightAnchor),
            topView.heightAnchor.constraint(equalToConstant: 120)
        ])

    }
    
    @objc func selecttopButton(sender: UIButton) {
        
        delegate?.canSelectOption(self, index: sender.tag, currentView: 0)
        
        delegate?.selectOption(self, at: sender.tag, currentView: 0)
        
        UIView.animate(withDuration: 0.5) {
            self.topConstraint?.isActive = false
            self.topConstraint = self.topindicatorView.centerXAnchor.constraint(equalTo: self.topbuttons[sender.tag].centerXAnchor)
            self.topConstraint?.isActive = true
            self.layoutIfNeeded()
        }
                
    }
    
    @objc func selectbottomButton(sender: UIButton) {
        
        guard optionisEnable == true else { return }
        
        delegate?.selectOption(self, at: sender.tag, currentView: 1)
        UIView.animate(withDuration: 0.5) {
            self.bottomConstraint?.isActive = false
            self.bottomConstraint = self.bottomindicatorView.centerXAnchor.constraint(equalTo: self.bottomButtons[sender.tag].centerXAnchor)
            self.bottomConstraint?.isActive = true
            self.layoutIfNeeded()
        }
        
    }

    
}

