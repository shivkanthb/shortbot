//
//  TableController.swift
//  shortbot
//
//  Created by Shivkanth B on 1/22/17.
//  Copyright © 2017 Shivkanth B. All rights reserved.
//

import UIKit

class TableController: UITableViewController {

    var cache: BotCache!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //It would probably be better to inject the BotCache with initializer
        cache = BotCache(with: UserDefaults.standard)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        refresh()
    }

    @IBAction func addBot(_ sender: Any) {
        let alertController = UIAlertController(title: "Bot", message: "Paste your bot url:", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            if let field = alertController.textFields?[0] {
                //Maybe add a name field for the bot?
                if let urlString = field.text,
                    let url = URL(string: urlString) {
                    self.cache.addBot(with: "Bot", url: url)
                    self.refresh()
                }

            } else {
                // user did not fill field
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Bot URL. Eg: m.me/botwonder"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cache.allBots.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        configure(cell, with:cache.allBots[indexPath.row])
        return cell
    }

    func configure(_ cell:UITableViewCell, with bot:Bot) {
        cell.textLabel?.text = bot.name
    }

    func refresh() {
        self.tableView.reloadData()
    }
}
