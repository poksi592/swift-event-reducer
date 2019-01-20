//
//  ButtonRow.swift
//  EventReducer
//
//  Created by Mladen Despotovic on 20.01.19.
//  Copyright © 2019 Mladen Despotovic. All rights reserved.
//

import Foundation
import UIKit

enum CellColor: Int {
	
	case blue
	case red
	case green
	case yellow
	
	var backgroundColor: UIColor {
		
		switch self {
		case .blue:
			return UIColor.blue
		case .red:
			return UIColor.red
		case .green:
			return UIColor.green
		case .yellow:
			return UIColor.yellow
		}
	}
	
	var tintColor: UIColor {
		
		switch self {
		case .yellow:
			return UIColor.blue
		default:
			return UIColor.white
		}
	}

}

class ButtonRowCell: UITableViewCell {
	
	func setEventEmitter(_ eventEmitter: DemoEventEmitter) {
		
		let buttons = contentView.subviews.compactMap { $0 as? Button }
		for button in buttons {
			button.eventEmitter = eventEmitter
		}
	}
}

class Button: UIButton, EventEmitting {

	var color: CellColor = .blue
	var value = Int.random(in: 0..<10)
	
	typealias EventEmitter = DemoEventEmitter
	var eventEmitter: DemoEventEmitter?
	
	override func awakeFromNib() {
		updateRandom()
	}
	
	func updateRandom() {
		color = CellColor(rawValue: Int.random(in: 0..<4)) ?? .blue
		value = Int.random(in: 1..<11)
		
		backgroundColor = color.backgroundColor
		tintColor = color.tintColor
		setTitle(String(value), for: .normal)
	}
}

