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
		
		guard let stackView = contentView.subviews.compactMap({ $0 as? UIStackView }).first  else { return }
		let buttons = stackView.arrangedSubviews.compactMap({ $0 as? Button })
		for button in buttons {
			button.eventEmitter = eventEmitter
			button.updateRandom()
		}
	}
}

class Button: UIButton, EventEmitting {

	var color: CellColor = .blue
	var value = Int.random(in: 0..<10)
	
	// MARK: EventEmitting
	typealias EventEmitter = DemoEventEmitter
	weak var eventEmitter: DemoEventEmitter?
	
	override func awakeFromNib() {
		updateRandom()
		setupTap()
	}
	
	func updateRandom() {
		color = CellColor(rawValue: Int.random(in: 0..<4)) ?? .blue
		value = Int.random(in: 1..<11)
		
		backgroundColor = color.backgroundColor
		tintColor = color.tintColor
		setTitle(String(value), for: .normal)
	}
}

extension Button {
	
	func setupTap() {
		self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
	}
	
	@objc func buttonTapped(sender: Button) {
		
		if let eventEmitter = eventEmitter {
			eventEmitter.notify(eventPayload: ["color" : color,
											   "value" : value])
		}
		animate(sender, transform: CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8))
	}
	
	private func animate(_ button: UIButton, transform: CGAffineTransform) {
		UIView.animate(withDuration: 0.1,
					   delay: 0,
					   usingSpringWithDamping: 0.5,
					   initialSpringVelocity: 3,
					   options: [.curveEaseInOut],
					   animations: {
						button.layer.setAffineTransform(transform)
		}, completion: { (finished: Bool) in
			button.transform =  CGAffineTransform.identity
		})
	}
}


