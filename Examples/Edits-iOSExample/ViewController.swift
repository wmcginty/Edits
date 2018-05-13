//
//  ViewController.swift
//  Edits
//
//  Created by William McGinty on 11/07/2016.
//  Copyright (c) 2016 William McGinty. All rights reserved.
//

import UIKit
import Edits

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var numbers: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9] {
        didSet {
            let transformer = Transformer(source: oldValue, destination: numbers)
            tableView.processUpdates(for: transformer, inSection: 0)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.numbers = [5, 6, 7, 8, 9, 1, 2, 3, 4]
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.numbers = [5, 7, 9, 1, 3]
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            self.numbers = [2, 4, 6, 8, 5, 7, 9, 1, 3]
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.numbers = [1, 2, 3, 4, 5, 6, 8, 7, 9]
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
            self.numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        }
    }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        cell.textLabel?.text = "\(numbers[indexPath.row])"
        
        return cell
    }
}
