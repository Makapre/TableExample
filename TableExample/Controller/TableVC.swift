//
//  TableVC.swift
//  TableExample
//
//  Created by Marius Preikschat on 02.05.22.
//

import UIKit

class TableVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    struct Sender {
        var label: String
        var image: UIImageView
    }
    
    var images = [UIImageView]()
    var data: CodableExample?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://api.publicapis.org/entries"
                
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    self.parse(json: data)
                }
            }.resume()
        }
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
            image.load(url: URL(string: "https://picsum.photos/200/300")!)
            images.append(image)
        }
        self.tableView.reloadData()
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonResult = try? decoder.decode(CodableExample.self, from: json) {
            data = jsonResult
            if let data = data {
                OperationQueue.main.addOperation {
                    self.title = String(data.count) + " Items"
                    self.addImages(data.count)
                }
            }
        }
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
