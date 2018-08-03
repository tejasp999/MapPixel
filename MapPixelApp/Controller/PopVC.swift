//
//  PopVC.swift
//  MapPixelApp
//
//  Created by Teja PV on 8/2/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit

class PopVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var popImageView: UIImageView!
    
    var passedImage : UIImage!
    
    func initData(forImage image: UIImage){
        self.passedImage = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popImageView.image = passedImage
        addDoubletap()
    }
    
    func addDoubletap(){
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(screenDismiss))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        view.addGestureRecognizer(doubleTap)
    }
    
    @objc func screenDismiss(){
        dismiss(animated: true, completion: nil)
    }

}
