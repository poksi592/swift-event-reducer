//
//  StateReducer.swift
//  EventReducer
//
//  Created by Mladen Despotovic on 21.01.19.
//  Copyright © 2019 Mladen Despotovic. All rights reserved.
//

import Foundation

/**
Protocol is to be implemented by objects-reducers which take events, process them and turn into state, which is
then sent to all subsriber objects.
Reducers don't know who their listeners are and they are themselves subscribed to `EventEmitterProtocol` object in the same way
*/
protocol StateReducerProtocol: class {
	
	associatedtype State
	typealias StateCallbackClosure = (State) -> Void
	
	var state: State { get set }
	
	/**
	Function adds subscriber's callback to
	- parameters:
	- listener: returns the state that was associated with it in implementation
	*/
	func subscribe(_ listener: @escaping StateCallbackClosure)
	
	/**
	Deletes all subscribers
	*/
	func unsubscribeAll()
	
	/**
	Contains collection of all subscriber's callback closures
	*/
	var callbacks: [StateCallbackClosure] {get set}
	
	/**
	Queue used for notifying
	*/
	var serialQueue: DispatchQueue {get set}
}

extension StateReducerProtocol {
	
	func subscribe(_ listener: @escaping StateCallbackClosure) {
		
		callbacks.append(listener)
	}
	
	func unsubscribeAll() {
		
		callbacks.removeAll()
	}
	
	func notify() {
		
		serialQueue.sync {
			
			callbacks.forEach { $0(state) }
		}
	}
}
