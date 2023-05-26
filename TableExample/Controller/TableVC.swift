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
            OperationQueue.main.addOperation {
                self.title = String(data.count) + " Items"
                self.addImages(data.count)
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
    
    func addImages(_ count: Int){
        for _ in 0..<(count) {
            let image = UIImageView()
            let url = URL(string: "https://picsum.photos/200/300")
            // own UIImageView extension
            //image.load(url: url!)
            
            // Kingfisher saves image in cache, not what I want for now, but good to know
            image.kf.setImage(with: url)
            images.append(image)
        }
        self.tableView.reloadData()
    }
}

extension TableVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = data else { return 0 }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! TableViewCell
        
        cell.TableViewCellLabel.text = data?.entries[indexPath.row].API
        cell.TableViewSecondLabel.text = data?.entries[indexPath.row].Category
        cell.TableViewCellImage.image = images[indexPath.row].image
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailLabelText = data?.entries[indexPath.row].Description ?? String(indexPath.row)
        performSegue(withIdentifier: "ShowDetail", sender: Sender(label: detailLabelText, image: images[indexPath.row]))
    }
}
