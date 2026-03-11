import Foundation
public struct GematriaKit {
	public init() {
		
	}
	let specials = [
		"15": "טו",
		"16": "טז",
		"115": "קטו",
		"116": "קטז",
		"215": "רטו",
		"216": "רטז",
		"270": "ער",
		"272": "ערב",
		"274": "עדר",
		"275": "ערה",
		"298": "רחצ",
		"304": "דש",
		"315": "שטו",
		"316": "שטז",
		"344": "שדמ",
		"415": "תטו",
		"416": "תטז",
		"515": "תקטו",
		"516": "תקטז",
		"615": "תרטו",
		"616": "תרטז",
		"670": "עתר",
		"672": "תערב",
		"674": "עדרת",
		"698": "תרחצ",
		"715": "תשטו",
		"716": "תשטז",
		"744": "תשדמ",
		"815": "תתטו",
		"816": "תתטז",
		"915": "תתקטו",
	]
	
	let map = [
		"0": "0",
		"1":"א",
		"2":"ב",
		"3":"ג",
		"4":"ד",
		"5":"ה",
		"6":"ו",
		"7":"ז",
		"8":"ח",
		"9":"ט",
		"10":"י",
		"20":"כ",
		"30":"ל",
		"40":"מ",
		"50":"נ",
		"60":"ס",
		"70":"ע",
		"80":"פ",
		"90":"צ",
		"100":"ק",
		"200":"ר",
		"300":"ש",
		"400":"ת",
	]
	
	/// Convert the given number to Hebrew Numerals
	/// - Parameters:
	///   - int: The number to be converted
	///   - addGeresh: determines if a Geresh ("׳׳") is added to the output
	/// - Returns: The number converted to hebrew numerals
	/// > WARNING: This doesn't work correctly for integers greater than 915
	public func toHebrew(int: Int, addGeresh: Bool = false) -> String {
		var newStr = ""
		let string = "\(int)"
		if let special = specials[string] {
			newStr = special
			//todo: add geresh
			if addGeresh {
				newStr = _addGeresh(string: newStr)
			}
			return newStr
		}
		var rest = Array(string)
		while rest.count > 0 {
			let digit = Int(String(rest[0]))!
			rest = Array(rest[1...])
			if digit == 0 {
				continue
			}
			let power = 10 ^^ rest.count
			let stringToAppend = map["\(power * digit)"]!
			newStr.append(stringToAppend)
		}
		if addGeresh {
			newStr = _addGeresh(string: newStr)
		}
		return newStr
	}
	
	private func _addGeresh(string: String) -> String {
		guard string.count > 1 else {return string}
		var newString = string
		newString.insert(contentsOf: "׳׳", at: newString.index(newString.endIndex, offsetBy: -1))
		return newString
	}
}
precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ^^ : PowerPrecedence
func ^^ (radix: Int, power: Int) -> Int {
	return Int(pow(Double(radix), Double(power)))
}
