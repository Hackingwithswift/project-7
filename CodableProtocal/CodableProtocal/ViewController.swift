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
        
        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"

        if  let url = URL(string: urlString) {
            print("the string is:\(url))")
            
            if let data = try? Data(contentsOf: url) {

                // wew work here
                
                parse(json: data)
                
            }
        }
        
        
    }
    func parse(json: Data){
          let decoder = JSONDecoder()

          if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
              tableView.reloadData()
          }
        
        
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return petitions.count
        print(petitions.count)
        return petitions.count
    }
    
    //- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;


//   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "NavController", for: indexPath)
//        cell.textLabel?.text = "Title goes here"
//        cell.detailTextLabel?.text = "Subtitle goes here"
//        return cell
//    }
//
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        let petition = petitions[indexPath.row]
        
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        cell.textLabel?.text = "Title goes here"
//        cell.detailTextLabel?.text = "Subtitle goes here"
//        return cell
//
//    }

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
    
    
}

