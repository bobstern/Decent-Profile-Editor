//  Utilities.swift
//  Decent Profile Editor

import Foundation

func rnd(_ x: String) -> String {
    return roundDecimalToString(x, minFractionDigits: 0, maxFractionDigits: 1)
}
func roundDecimalToString(_ dbl: Double, minFractionDigits: Int, maxFractionDigits: Int) -> String {
    let numFormatter = NumberFormatter()
    numFormatter.minimumIntegerDigits = 1
    numFormatter.minimumFractionDigits = minFractionDigits
    numFormatter.maximumFractionDigits = maxFractionDigits
    return numFormatter.string(from: NSNumber(value: dbl)) ?? ""
}
func roundDecimalToString(_ x: String, minFractionDigits: Int, maxFractionDigits: Int) -> String {
    if let num = NumberFormatter().number(from: x), let dbl = num as? Double {
        return roundDecimalToString(dbl, minFractionDigits: minFractionDigits, maxFractionDigits: maxFractionDigits)
    } else {
        return x
    }
}
