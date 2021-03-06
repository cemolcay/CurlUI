//
//  CUParametersTableView.swift
//  CurlUI
//
//  Created by Cem Olcay on 28/10/15.
//  Copyright © 2015 prototapp. All rights reserved.
//

import Cocoa

class CUParameter {
    private var key: String!
    private var value: AnyObject!
    private var valueString: String!

    init () {
        key = ""
        value = ""
        valueString = ""
    }

    init (key: String!, value: AnyObject!) {
        self.key = key
        self.value = value
        self.valueString = "\(value)"
    }

    var isValid: Bool {
        return key != nil
    }
}

class CUParameters {
    private var parameters = [CUParameter]()
    var count: Int {
        return parameters.count
    }

    subscript(index: Int) -> CUParameter {
        return parameters[index]
    }

    func toURLParameter() -> String {
        var params = ""
        for parameter in parameters {
            params += (params.rangeOfString("?") == nil ? "?" : "&") + parameter.key + "=" + parameter.valueString
        }
        return params
    }

    func toDictionary() -> [String: AnyObject]? {
        if count == 0 {
            return nil
        }
        var params = [String: AnyObject]()
        for parameter in parameters {
            if parameter.isValid {
                params[parameter.key] = parameter.value
            }
        }
        return params
    }

    func add(parameter: CUParameter) {
        parameters.append(parameter)
    }

    func removeAtIndex(index: Int) {
        parameters.removeAtIndex(index)
    }
}

enum CUParametersTableViewColumn: Int {
    case Key = 0
    case Value = 1
}

class CUParametersTableView: NSTableView, NSTableViewDelegate, NSTableViewDataSource {

    private var parameters = CUParameters()
    private var currentColumn: CUParametersTableViewColumn?

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        initilize()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initilize()
    }

    func initilize() {
        self.setDelegate(self)
        self.setDataSource(self)
    }

    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return parameters.count
    }

    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        let parameter = self.parameters[row]
        return tableColumn?.title == "Key" ? parameter.key : parameter.value
    }

    func getParameters() -> [String: AnyObject]? {
        return parameters.toDictionary()
    }

    func addNewParameter() {
        let parameter = CUParameter()
        parameters.add(parameter)
        reloadData()
    }

    func removeParameter() {
        if selectedRow == -1 {
            return
        }
        parameters.removeAtIndex(selectedRow)
        reloadData()
    }

    func tableView(tableView: NSTableView, shouldEditTableColumn tableColumn: NSTableColumn?, row: Int) -> Bool {
        if let column = tableColumn {
            if let index = tableColumns.indexOf(column) {
                currentColumn = CUParametersTableViewColumn(rawValue: index)
            }
        }
        return true
    }

    override func controlTextDidEndEditing(obj: NSNotification) {
        guard let currentColumn = currentColumn else { return }
        if let text = selectedCell()?.stringValue {
            let table = obj.object as! NSTableView
            let row = table.selectedRow
            switch currentColumn {
            case .Key:
                parameters[row].key = text
            case .Value:
                parameters[row].value = text
                parameters[row].valueString = text
            }
        }
    }
}
