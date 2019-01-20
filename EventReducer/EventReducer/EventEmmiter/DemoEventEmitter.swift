//
//  DemoEventEmitter.swift
//  EventReducer
//
//  Created by Mladen Despotovic on 20.01.19.
//  Copyright © 2019 Mladen Despotovic. All rights reserved.
//

import Foundation

enum DemoEvent: String {
	
	case blueButtonTapped
	case redButtonTapped
	case yellowButtonTapped
	case greedButtonTapped
}

final class DemoEventEmitter: EventEmitterType {
	
	var callbacks: [EventCallbackClosure] = []
	var serialQueue = DispatchQueue(label: "DemoEventNotifyQueue")
	
	init() {}
}
