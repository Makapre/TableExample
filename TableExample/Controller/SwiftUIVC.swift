//
//  SwiftUIVC.swift
//  TableExample
//
//  Created by Marius Preikschat on 06.09.23.
//

import Foundation
import UIKit
import SwiftUI

class SwiftUIVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1
        let vc = UIHostingController(rootView: SwiftUIView())
        
        let swiftuiView = vc.view!
        swiftuiView.translatesAutoresizingMaskIntoConstraints = false
        
        // 2
        // Add the view controller to the destination view controller.
        addChild(vc)
        view.addSubview(swiftuiView)
        
        // 3
        // Create and activate the constraints for the swiftui's view.
        NSLayoutConstraint.activate([
            swiftuiView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            swiftuiView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            swiftuiView.widthAnchor.constraint(equalTo: view.widthAnchor),
            swiftuiView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        // 4
        // Notify the child view controller that the move is complete.
        vc.didMove(toParent: self)
    }
}
