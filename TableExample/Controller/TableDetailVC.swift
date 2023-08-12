//
//  TableDetailVC.swift
//  TableExample
//
//  Created by Marius Preikschat on 02.05.22.
//

import UIKit
import Kingfisher
import SwiftUI
import Combine

class TableDetailVC: UIViewController {
    
    @Published var buttonEnabled: Bool = false
    
    var detailLabelText: String?
    var url: URL?
    
    // Save the cancellable subscription.
    private var subscribers: [AnyCancellable] = []
    private var switchSubscriber: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()

        DetailLabel.text = detailLabelText
        
        // MARK: setting image native and w/ library
        // w/ caching
        //DetailImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        
        // native implementation
        DetailImage.setImageFromUrl(url: url!)
        DetailImage.load(url: url!)
        
        // MARK: Add SwiftUI View to UIKit
        
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
        
        // MARK: Combine
        switchSubscriber = $buttonEnabled.sink { print("Received \($0)") }
        $buttonEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: switchButton)
            .store(in: &subscribers)
    }
    
    @IBAction func didSwitch(_ sender: UISwitch) {
        buttonEnabled = sender.isOn
    }
    
    @IBOutlet var DetailImage: UIImageView!
    @IBOutlet var DetailLabel: UILabel!
    @IBOutlet weak var switchButton: UIButton!
}
