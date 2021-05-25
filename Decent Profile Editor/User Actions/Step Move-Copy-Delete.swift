//  Step Move-Copy-Delete.swift
//  Decent Profile Editor

import Foundation

func duplicateStep(atIndex idx : Int) {
    let originalStep = vm.newProfile.shotSteps[idx]
    var duplicateStep = originalStep
    duplicateStep.id = UUID()
    vm.newProfile.shotSteps.insert(duplicateStep, at: idx)
}

func deleteStep(atIndex idx : Int) {
    vm.newProfile.shotSteps.remove(at: idx)
}

// onMove fails in Catalina:
// func moveSteps(from: IndexSet, dest: Int) {
//     vm.newProfile.shotSteps.move(fromOffsets: from, toOffset: dest)
// }

func moveDownOneStep(fromIndex: Int) {
    let firstElement = vm.newProfile.shotSteps.remove(at: fromIndex)
    vm.newProfile.shotSteps.insert(firstElement, at: fromIndex+1)
}
