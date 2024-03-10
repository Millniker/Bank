//
//  StringFormatter.swift
//  BankClient
//
//  Created by Nikita Usov on 10.03.2024.
//

import Foundation

final class StringFormatter {
  static func format(text: String, by mask: String) -> String {
	var resultString = ""
	var index = text.startIndex

	for char in mask where index < text.endIndex {
	  if char == text[index] {
		index = text.index(after: index)
	  } else if char == "X" {
		resultString.append(text[index])
		index = text.index(after: index)
	  } else {
		resultString.append(char)
	  }
	}

	return resultString
  }

  static func remove(chars: CharacterSet, from text: String) -> String {
	let passed = text.unicodeScalars.filter { !chars.contains($0)}
	return String(String.UnicodeScalarView(passed))
  }
}
