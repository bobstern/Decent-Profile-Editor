//  Loop Shot Input & Output Files.swift
//  Decent Shot - Export to Table
//  Bob Stern 2020-07-12

import Cocoa

extension ViewModel {
    
    func shotFilesOpenDialog(window: NSWindow) {
        // var shotTSVandHeadingConcatenated = "" // for export to TSV.
        let openPanel = NSOpenPanel()
        openPanel.allowedFileTypes = ["tcl", "shot"]
        openPanel.allowsMultipleSelection = false
        let openPanelResponse = openPanel.runModal()
        
        // Xcode BUG: Freezes if press Cancel, so must test app outside Xcode.
        // TO DO:  Need to test whether press Cancel button;
        // so loads selected file as if you'd pressed OK!
        guard openPanelResponse == .OK else {return}
        
        let shotFileURL = openPanel.urls[0]
        var shotPathArray = shotFileURL.path.components(separatedBy: "/")
        _ = shotPathArray.removeLast()
        let shotContainerPath = shotPathArray.joined(separator: "/") + "/"
        // print(shotContainerPath)
        guard (shotFileURL.pathExtension == "tcl") || (shotFileURL.pathExtension == "shot") else {return}
        // url contents = nil if user canceled open dialog:
        guard let shotInputTcl = try? String(contentsOf: shotFileURL) else {return}
        // self.oldProfile = Profile(fromTcl: shotInputTcl, shotContainerPath: shotContainerPath)
        self.profile = Profile(fromTcl: shotInputTcl, shotContainerPath: shotContainerPath, window: window)
        // self.newProfile.inputFileName = shotFileURL.lastPathComponent // includes extension
        self.dirty =  false
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
    
}
