//
//  Menu Actions.swift
//  HQP Mac
//
//  Created by bob on 11/21/2021.
//

import Foundation

// Menu action calls closure in .onCommand view modifier in whichever view is active.
// .onCommand must specify #selector identifying this class name and one of its functions.
// eg: .onCommand( #selector(MenuActions.playMenu) ) { }

// Cntl-drag from Storyboard menu item to this class
// and specify target object as First Responder.
// Circle is never filled black.

class MenuActions {

    @IBAction func deleteMenu (_ sender: Any) {
        print("DELETE MENU ITEM PRESSED")
    }
    
    @IBAction func openMenu(_ sender: Any) {
        print("OPEN MENU ITEM PRESSED")
    }
    
    @IBAction func copyTclMenu(_ sender: Any) {
        print("COPY TCL MENU ITEM PRESSED")
    }
    
    @IBAction func saveTclMenu(_ sender: Any) {
        print("SAVE MENU ITEM PRESSED")
    }
    
    @IBAction func copyTclMenu2(_ sender: Any) {
        print("PLAY MENU ITEM PRESSED")
    }
}
