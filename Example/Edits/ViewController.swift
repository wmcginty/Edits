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
    
    var numbers: [Int] = [1,2,3,4,5,6,7,8,9] {
        didSet {
            let transformer = TransformerFactory.transformer(from: oldValue, to: numbers)
            tableView.processUpdates(for: transformer, inSection: 0)
        }
        
    }
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.numbers = [1,2,4,5,6,7,9,8]
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            self.numbers = [1,4,3,2,5,6,9,8]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

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

