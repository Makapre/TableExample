//
//  TableDetailVC.swift
//  TableExample
//
//  Created by Marius Preikschat on 02.05.22.
//

import UIKit
import Kingfisher
import SwiftUI

class TableDetailVC: UIViewController {
    
    var detailLabelText: String?
    var url: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        DetailLabel.text = detailLabelText
        // w/ caching
        //DetailImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        
        // native implementation
        DetailImage.setImageFromUrl(url: url!)
        DetailImage.load(url: url!)
        
        // 1
        let vc = UIHostingController(rootView: ButtonView())
        
        let buttonView = vc.view!
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        
        // 2
        // Add the view controller to the destination view controller.
        addChild(vc)
        view.addSubview(buttonView)
        
        // 3
        // Create and activate the constraints for the swiftui's view.
        NSLayoutConstraint.activate([
            buttonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonView.topAnchor.constraint(equalTo: self.view.topAnchor),
        ])
        
        // 4
        // Notify the child view controller that the move is complete.
        vc.didMove(toParent: self)
    }
    
    @IBOutlet var DetailImage: UIImageView!
    @IBOutlet var DetailLabel: UILabel!
}
