//
//  CUViewController.swift
//  CurlUI
//
//  Created by Cem Olcay on 28/10/15.
//  Copyright © 2015 prototapp. All rights reserved.
//

import Cocoa

class CUViewController: NSViewController {
    @IBOutlet var urlTextField: NSTextField!
    @IBOutlet var methodComboBox: NSComboBox!
    @IBOutlet var parametersTableView: CUParametersTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        methodComboBox.selectItemAtIndex(0)
    }

    @IBAction func addButtonPressed(sender: AnyObject) {
        parametersTableView.addNewParameter()
    }

    @IBAction func removeButtonPressed(sender: AnyObject) {
        parametersTableView.removeParameter()
    }

    @IBAction func requestButtonPressed(sender: AnyObject) {
        let url = urlTextField.stringValue
        let method = CURequestMethod(rawValue: methodComboBox.indexOfSelectedItem)!
        let parameters = parametersTableView.getParameters()
        CURequest.request(url,
            method: method,
            parameters: parameters,
            success: { output in
                let outputParameters = CUOutputParameters(
                    url: url, 
                    output: output)
                self.performSegueWithIdentifier("output", sender: outputParameters)
            })
    }

    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "output" {
            let outputViewController = segue.destinationController as! CUOutputViewController
            let outputParameters = sender as! CUOutputParameters
            outputViewController.outputParameters = outputParameters
        }
    }
}