//
//  TableDetailVC.swift
//  TableExample
//
//  Created by Marius Preikschat on 02.05.22.
//

import UIKit

class TableDetailVC: UIViewController {
    
    var detailLabelText: String?
    var detailImage: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        DetailLabel.text = detailLabelText
        DetailImage.image = detailImage?.image
    }
    

    @IBOutlet var DetailImage: UIImageView!
    @IBOutlet var DetailLabel: UILabel!
}
