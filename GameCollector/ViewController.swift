//
//  ViewController.swift
//  GameCollector
//
//  Created by Adam Gendle on 9/27/16.
//  Copyright © 2016 Adam Gendle. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var games : [Game] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            games = try context.fetch(Game.fetchRequest())
            tableView.reloadData()
        } catch {
            
            
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let game = games[indexPath.row]
        cell.textLabel?.text = game.title
        cell.imageView?.image = UIImage(data: game.image as! Data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let game = games[indexPath.row]
        performSegue(withIdentifier: "gameSegue", sender: game)
        
        
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let nextVC = segue.destination as! GameViewController
        nextVC.game = sender as? Game
    }
    
}

