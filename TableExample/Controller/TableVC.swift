//
//  TableVC.swift
//  TableExample
//
//  Created by Marius Preikschat on 02.05.22.
//

import UIKit
import Alamofire
import Kingfisher

class TableVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    struct Sender {
        var label: String
        var image: UIImageView
    }
    
    var images = [UIImageView]()
    var data: CodableExample?
    
    func fetchData() {
        AF.request("https://api.publicapis.org/entries")
            .validate()
            .responseDecodable(of: CodableExample.self) { response in
            guard let data = response.value else { return }
            self.data = data
            DispatchQueue.main.async {
                dump(String(data.count) + " Items")
                self.title = String(data.count) + " Items"
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Loading..."
        fetchData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! TableDetailVC
        let s = sender as! Sender
        destVC.detailLabelText = s.label
        destVC.detailImage = s.image
    }
}

extension TableVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = data else { return 0 }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! TableViewCell
        let url = URL(string: "https://picsum.photos/200/300")
        
        cell.TableViewCellLabel.text = data?.entries[indexPath.row].API
        cell.TableViewSecondLabel.text = data?.entries[indexPath.row].Category
        
        // w/ caching and kingfisher
        cell.TableViewCellImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        
//        own implementation, without caching, loads image new when scrolling and the cell is again visible
//        cell.TableViewCellImage.setImageFromUrl(url: url!)
//        cell.TableViewCellImage.load(url: url!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailLabelText = data?.entries[indexPath.row].Description ?? String(indexPath.row)
        performSegue(withIdentifier: "ShowDetail", sender: Sender(label: detailLabelText, image: images[indexPath.row]))
    }
}
