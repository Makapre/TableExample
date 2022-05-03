//
//  TableDetailVC.swift
//  TableExample
//
//  Created by Marius Preikschat on 02.05.22.
//

import UIKit

class TableDetailVC: UIViewController {
    
    var detailLabelText: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        DetailLabel.text = detailLabelText
    }
    

    @IBOutlet var DetailLabel: UILabel!
}
