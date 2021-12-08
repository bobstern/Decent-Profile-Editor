//  Export Tcl.swift
//  Decent Profile Editor

import Cocoa

extension ViewModel {

func clipboardExportTcl() {
    // let tcl = profileEncodeTcl(self.newProfile)
    let tcl = self.profile.encodeTcl()
    NSPasteboard.general.setString(tcl, forType: .string)
//    clipboard.clearContents()
//    clipboard.setString(tcl, forType: .string)
}

func tclSavePanel() {
    // let tcl = profileEncodeTcl(self.newProfile)
    let tcl = self.profile.encodeTcl()
//    clipboard.clearContents()
//    clipboard.setString(self.newProfile.profileTitle+".tcl", forType: .string)
    
    var saveNameOffered = "\(self.profile.profileTitle).tcl"
    if filemgr.fileExists(atPath: self.profile.shotContainerPath + saveNameOffered) {
        saveNameOffered = "\(self.profile.profileTitle)  (\(dateFormatter.string(from: Date())))"
    }
    let savePanel = NSSavePanel()
    savePanel.allowedFileTypes = ["tcl"]
    savePanel.nameFieldStringValue = saveNameOffered
    let saveResult = savePanel.runModal()
    // 2021-05-16 02:24:44.617031-0700 Decent Profile Editor[39056:2642803] WARNING: <NSSavePanel: 0x1005399f0> found it necessary to prepare implicitly; please prepare panels using NSSavePanel rather than NSApplication or NSWindow.
    // 2021-05-16 02:24:45.641632-0700 Decent Profile Editor[39056:2642803] WARNING: <NSSavePanel: 0x1005399f0> found it necessary to start implicitly; please start panels using NSSavePanel rather than NSApplication or NSWindow.
    // 2021-05-16 02:24:45.641731-0700 Decent Profile Editor[39056:2642803] WARNING: <NSSavePanel: 0x1005399f0> running implicitly; please run panels using NSSavePanel rather than NSApplication.
    guard saveResult == NSApplication.ModalResponse.OK else {return}
    // guard saveResult.rawValue == 1 else {return}
    guard let savePath = savePanel.url?.path else {return}
    // Don't interfere cuz overwrite warning already in Save dialog:
//    if filemgr.fileExists(atPath: savePath) {
//        self.overwriteFilePath = savePath
//        //self.overwriteFileConfirmed = false
//        self.overwriteFileAlert = true
//    } else {
//        filemgr.createFile(atPath: savePath, contents: Data(tcl.utf8))
//    }
    filemgr.createFile(atPath: savePath, contents: Data(tcl.utf8))
    self.dirty = false
}

func tclSaveImmediately() {
    // self.overwriteFileConfirmed = false
    // let tcl = profileEncodeTcl(self.newProfile)
    let tcl = self.profile.encodeTcl()
    filemgr.createFile(atPath: self.overwriteFilePath, contents: Data(tcl.utf8))
    self.dirty = false
}


}
