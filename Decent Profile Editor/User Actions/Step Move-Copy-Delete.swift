//  Step Move-Copy-Delete.swift
//  Decent Profile Editor

import Foundation

extension ViewModel {

func duplicateStep(atIndex idx : Int) {
    let originalStep = self.newProfile.shotSteps[idx]
    var duplicateStep = originalStep
    duplicateStep.id = UUID()
    self.newProfile.shotSteps.insert(duplicateStep, at: idx)
}

func deleteStep(atIndex idx : Int) {
    self.newProfile.shotSteps.remove(at: idx)
}

// onMove fails in Catalina:
// func moveSteps(from: IndexSet, dest: Int) {
//     vm.newProfile.shotSteps.move(fromOffsets: from, toOffset: dest)
// }

func moveDownOneStep(fromIndex: Int) {
    let firstElement = self.newProfile.shotSteps.remove(at: fromIndex)
    self.newProfile.shotSteps.insert(firstElement, at: fromIndex+1)
}
}
