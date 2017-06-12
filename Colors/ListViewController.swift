//
//  ListViewController.swift
//  Colors
//
//  Created by Thiago Lioy on 12/06/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let colors: [Color] = [
         Color(name: "Red", color: UIColor.red),
         Color(name: "Yellow", color: UIColor.yellow),
         Color(name: "Blue", color: UIColor.blue),
         Color(name: "Black", color: UIColor.black),
         Color(name: "Cyan", color: UIColor.cyan)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath,
                                                 cellType: ColorCell.self)
        let color = colors[indexPath.row]
        cell.setup(with:color)
        
        return cell
    }
    
}


extension ListViewController {
    static func fromStoryboard() -> ListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
    }
}
