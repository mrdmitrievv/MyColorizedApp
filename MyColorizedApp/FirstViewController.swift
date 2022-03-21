//
//  ViewController.swift
//  MyColorizedApp
//
//  Created by Артём Дмитриев on 19.03.2022.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let setColorVC = segue.destination as! SetColorViewController
        setColorVC.delegate = self
        
        setColorVC.colorizedViewColor = view.backgroundColor
    }
}

extension FirstViewController: ColorViewControllerDelegate {
    func saveColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
