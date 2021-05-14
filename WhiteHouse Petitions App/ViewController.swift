//
//  ViewController.swift
//  WhiteHouse Petitions App
//
//  Created by Satinder Panesar on 5/11/21.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString:String
        if navigationController?.tabBarItem.tag == 0{
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        }else{
            // https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100
            urlString =
                "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        }
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                // we're ok to parse
                parse(json: data)
                return
            }
        }
        showError()
    }
    func showError()
    {
        let ac = UIAlertController(title: "Loading error", message: "there was problem loading the the feed;please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true, completion: nil)
    }
    // MARK:- JSON parsing method
    func parse(json:Data){
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json){
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
        
    }
    //MARK:- Tableview Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

