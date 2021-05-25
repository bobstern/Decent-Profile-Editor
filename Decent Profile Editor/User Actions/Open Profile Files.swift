//  Loop Shot Input & Output Files.swift
//  Decent Shot - Export to Table
//  Bob Stern 2020-07-12

import Cocoa

func shotFilesOpenDialog() {
    // var shotTSVandHeadingConcatenated = "" // for export to TSV.
    let openPanel = NSOpenPanel()
    openPanel.allowedFileTypes = ["tcl", "shot"]
    openPanel.allowsMultipleSelection = false
    openPanel.runModal()
    let shotFileURL = openPanel.urls[0]
    var shotPathArray = shotFileURL.path.components(separatedBy: "/")
    _ = shotPathArray.removeLast()
    let shotContainerPath = shotPathArray.joined(separator: "/") + "/"
    // print(shotContainerPath)
    guard (shotFileURL.pathExtension == "tcl") || (shotFileURL.pathExtension == "shot") else {return}
    // url contents = nil if user canceled open dialog:
    guard let shotInputTcl = try? String(contentsOf: shotFileURL) else {return}
    // vm.oldProfile = Profile(fromTcl: shotInputTcl, shotContainerPath: shotContainerPath)
    vm.newProfile = Profile(fromTcl: shotInputTcl, shotContainerPath: shotContainerPath)
    // vm.newProfile.inputFileName = shotFileURL.lastPathComponent // includes extension
    vm.dirty =  false
}



/*
// MARK: Shot Dict –> TSV –> Clipboard & Nisus
//        shotTSVandHeadingConcatenated += "File = \(shot.inputFileName)\nProfile title = \(shot.profileTitle)\n\(shot.shotTSV)\n\n"
        
        
//    } // end loopShotFiles()
    
//    if !shotTSVandHeadingConcatenated.isEmpty {
//        clipboard.clearContents()
//        clipboard.setString(shotTSVandHeadingConcatenated, forType: .string)
//         runNisusMacro()
//    }
// } // end shotFilesOpenDialogAndLoop()
*/
