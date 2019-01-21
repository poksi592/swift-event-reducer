//
//  ViewController.swift
//  EventReducer
//
//  Created by Mladen Despotovic on 20.01.19.
//  Copyright © 2019 Mladen Despotovic. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, EventEmitting {
	
	// MARK: EventEmitting
	typealias EventEmitter = DemoEventEmitter
	var eventEmitter: DemoEventEmitter? = DemoEventEmitter()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let nib = UINib.init(nibName: "ButtonRowCell", bundle: nil)
		tableView.register(nib, forCellReuseIdentifier: "cell")

		self.tableView.delegate = self
		self.tableView.dataSource = self
	}
}

extension ViewController {

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 20;
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! ButtonRowCell
		if let eventEmitter = eventEmitter {
			cell.setEventEmitter(eventEmitter)
		}
		return cell
	}
}


