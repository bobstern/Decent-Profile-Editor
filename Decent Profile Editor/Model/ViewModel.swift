//  ViewModel.swift
//  Decent Profile Editor

import Foundation


// let vm = ViewModel.singleton // 1-window only.
class ViewModel : ObservableObject {
    // static let singleton = ViewModel()
    init () {
        print("INIT ViewModel")
    } // was private for singleton single-window version
    
    // Initializing to default values reqd to instantiate singleton.
    // Defaults are reasonable for Profile but arbitrary for ShotStep.
    // @Published var oldProfile = Profile()
    @Published var newProfile = Profile() {didSet {dirty = true} }
    @Published var overwriteFileAlert = false
    @Published var overwriteFilePath = ""
    @Published var dirty = false
    @Published var deleteBugBlankDisplay = false
    var saveButtonTxt : String {
        switch dirty {
        case true:
            return "**SAVE**"
        case false:
            return "  Save  "
        }
    }
    // @Published var overwriteFileConfirmed = false
    // @Published var currentStep = ShotStep()
    
    var dummyShotStep = ShotStep()

    
    func setDirty() {
        dirty = true
    }
}
