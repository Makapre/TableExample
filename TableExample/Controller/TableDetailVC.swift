//
//  TableDetailVC.swift
//  TableExample
//
//  Created by Marius Preikschat on 02.05.22.
//

import UIKit
import Kingfisher

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
    }
    
    @IBOutlet var DetailImage: UIImageView!
    @IBOutlet var DetailLabel: UILabel!
}
