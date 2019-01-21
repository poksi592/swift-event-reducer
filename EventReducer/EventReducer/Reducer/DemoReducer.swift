//
//  DemoReducer.swift
//  EventReducer
//
//  Created by Mladen Despotovic on 21.01.19.
//  Copyright © 2019 Mladen Despotovic. All rights reserved.
//

import Foundation

enum DemoState {
	
	case cleanSlate
	case progress([CellColor : Int])
	case overflow
}

class DemoStateReducer: StateReducerProtocol, EventEmitting {

	//	MARK: EventEmitting
	typealias EventEmitter = DemoEventEmitter
	var eventEmitter: DemoEventEmitter?
	
	typealias State = DemoState
	
//	 ?????
	static let shared = DemoStateReducer()
	
	var state: DemoState = .cleanSlate {
		didSet {
			notify()
		}
	}
	var serialQueue = DispatchQueue(label: "notifyQueue")
	var callbacks: [StateCallbackClosure] = []
	
	init() {}
}

extension DemoStateReducer {
	
	func subscribeToEventEmitter() {
		eventEmitter?.subscribe { [weak self] (payload) in
			
			guard let color = payload["color"] as? CellColor,
					let value = payload["value"] as? Int else  { return }
			
			self?.reduce(color: color, value: value)
		}
	}
	
	func reduce(color: CellColor, value: Int) {
		if case .progress(let colorValues) = state {
			let newValue = colorValues[color] ?? 0 + value
			state = .progress([color : newValue])
		}
		else {
			state = .progress([color : value])
		}
	}
	
	func reduceToLimit() {
		
//		Reduces the state if any color exceedes the limit of 25
		if case .progress(let colorValues) = state {
			
			let color: CellColor? = colorValues.reduce(nil) { (currentValue, arg1) -> CellColor? in
				
				let (key, value) = arg1
				if value >= 25 {
					return key
				}
				else {
					return nil
				}
			}
			if let exceedingColor = color {
				
			}
		}
	}
}
