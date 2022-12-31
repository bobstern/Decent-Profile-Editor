//  Step Move-Copy-Delete.swift
//  Decent Profile Editor

import Foundation

extension Model {

func duplicateStep(atIndex idx : Int) {
    let originalStep = self.profile.shotSteps[idx]
    var duplicateStep = originalStep
    duplicateStep.id = UUID()
    self.profile.shotSteps.insert(duplicateStep, at: idx)
}

func deleteStep(atIndex idx : Int) {
    self.profile.shotSteps.remove(at: idx)
}

// onMove fails in Catalina:
// func moveSteps(from: IndexSet, dest: Int) {
//     vm.newProfile.shotSteps.move(fromOffsets: from, toOffset: dest)
// }

func moveDownOneStep(fromIndex: Int) {
    let firstElement = self.profile.shotSteps.remove(at: fromIndex)
    self.profile.shotSteps.insert(firstElement, at: fromIndex+1)
}
}
