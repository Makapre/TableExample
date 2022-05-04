//
//  TableVC.swift
//  TableExample
//
//  Created by Marius Preikschat on 02.05.22.
//

import UIKit

class TableVC: UIViewController {
    
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
            if let data = try? Data(contentsOf: url) {
                // we're OK to parse!
                parse(json: data)
            }
        }
        addImages()
        print(data?.count)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! TableDetailVC
        let s = sender as! Sender
        destVC.detailLabelText = s.label
        destVC.detailImage = s.image
    }
    
    func addImages(){
        for _ in 0..<(data?.count ?? 50) {
            let image = UIImageView()
            image.load(url: URL(string: "https://picsum.photos/200/300")!)
            images.append(image)
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonResult = try? decoder.decode(CodableExample.self, from: json) {
            data = jsonResult
            if let newTitle = data?.count {
                self.title = String(newTitle) + " Items"
            }
        }
    }
}

extension TableVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data?.count ?? 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! TableViewCell
        
        cell.TableViewCellLabel.text = data?.entries[indexPath.row].API
        cell.TableViewSecondLabel.text = data?.entries[indexPath.row].Category
        cell.TableViewCellImage.image = images[indexPath.row].image
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailLabelText = String(indexPath.row)
        performSegue(withIdentifier: "ShowDetail", sender: Sender(label: detailLabelText, image: images[indexPath.row]))
    }
}
