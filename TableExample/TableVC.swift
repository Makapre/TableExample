//
//  TableVC.swift
//  TableExample
//
//  Created by Marius Preikschat on 02.05.22.
//

import UIKit

class TableVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! TableDetailVC
        destVC.detailLabelText = sender as? String
    }
}

extension TableVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailLabelText = String(indexPath.row)
        performSegue(withIdentifier: "ShowDetail", sender: detailLabelText)
    }
}
