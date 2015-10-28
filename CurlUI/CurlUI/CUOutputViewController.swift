//
//  CUOutputViewController.swift
//  CurlUI
//
//  Created by Cem Olcay on 28/10/15.
//  Copyright © 2015 prototapp. All rights reserved.
//

import Cocoa

class CUOutputParameters {
    var url: String
    var output: String

    init (url: String, output: String) {
        self.url = url
        self.output = output
    }
}

class CUOutputViewController: NSViewController {
    @IBOutlet var urlTextField: NSTextField!
    @IBOutlet var outputTextView: NSTextView!
    var outputParameters: CUOutputParameters!

    override func viewDidLoad() {
        super.viewDidLoad()
        urlTextField.stringValue = outputParameters.url
        outputTextView.string = outputParameters.output
    }
    
    @IBAction func closeButtonPressed(sender: AnyObject) {
        dismissController(self)
    }
}
