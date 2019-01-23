//
//  OverlayViewController.swift
//  EventReducer
//
//  Created by Mladen Despotovic on 23.01.19.
//  Copyright © 2019 Mladen Despotovic. All rights reserved.
//

import Foundation
import UIKit

class OverlayViewController: UIViewController {
	
	@IBOutlet weak var closeButton: UIButton!

	@IBAction func tapCloseButton(sender: UIButton) {
		self.dismiss(animated: true, completion: nil)
	}
}
