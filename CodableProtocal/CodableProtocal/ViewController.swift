//
//  ViewController.swift
//  CodableProtocal
//
//  Created by Veerababu Mulugu on 7/31/19.
//  Copyright © 2019 Veerababu Mulugu. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.title = "Codable"
        
        performSelector(inBackground: #selector(fetchJSON), with: nil)
        
    }
    @objc func fetchJSON(){
        
        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        if  let url = URL(string: urlString) {
            print("the string is:\(url))")
            if let data = try? Data(contentsOf: url) {
                // wew work here
                parse(json: data)
                
            }
        }

    }
    
    @objc func parse(json: Data){
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.performSelector(onMainThread: #selector(tableView.reloadData), with: nil, waitUntilDone: false)
        }else {
                    performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return petitions.count
        print(petitions.count)
        return petitions.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    func tableView(tableView: UITableViewDelegate, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        print("wananananaanan" )
        print("You deselected cell #\(indexPath.row)!")
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Did select method is called")
        let vc  = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
    
    @objc func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        
    }
    
}
