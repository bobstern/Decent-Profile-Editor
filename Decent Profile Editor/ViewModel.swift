//  ViewModel.swift
//  Decent Profile Editor

import Foundation


let vm = ViewModel.singleton
class ViewModel : ObservableObject {
    static let singleton = ViewModel()
    private init () {}
    
    // Initializing to default values reqd to instantiate singleton.
    // Defaults are reasonable for Profile but arbitrary for ShotStep.
    @Published var oldProfile = Profile()
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
