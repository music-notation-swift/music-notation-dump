//
//  main.swift
//  music-notation-dump
//
//  Created by Steven Woolgar on 2025-01-04.
//	Copyright © 2025 Steven Woolgar. All rights reserved.
//

import ArgumentParser
import Foundation
import MusicNotation
import MusicNotationImportMuseScore

let argumentHelp: ArgumentHelp = """
A filename of a file to import.

Currently supported music notation file types include:
	• MuseScore 4 - These are zipped XML files
"""

// swiftlint:disable type_name
struct mncdump: AsyncParsableCommand {
	@Argument(help: argumentHelp, transform: { URL(fileURLWithPath: NSString(string: $0).expandingTildeInPath) }) var files: [URL]
	@Flag(name: [.customLong("graphviz"), .customShort("g")], help: "Dump to dot file (GraphViz format).") var graphviz = false
	@Flag(name: [.customLong("text"), .customShort("t")], help: "Dump to text file (Text format).") var text = false

	mutating func validate() throws {
		for file in files {
			if file.isFolder {
				throw ValidationError("`\(file.lastPathComponent)` is a folder.")
			}

			if !file.fileExists {
				throw ValidationError("`\(file.lastPathComponent)` not found.")
			}

			if !file.hasExtension(["mscz", "mscx"]) {
				throw ValidationError("`\(file.lastPathComponent)` doesn't have supported import file extension.")
			}
		}
	}

	func run() throws {
		for file in files {
			let fileExtension = file.pathExtension
			switch fileExtension {
			case "mscz", "mscx":
				let importer = MuseScoreImporter(file: file, verbose: false, lazy: false)
				let score = try importer.consume()
				dump(score: score, graphviz: graphviz, text: text)
			default:
				throw ValidationError("`\(file.lastPathComponent)` Unsupported file type \(fileExtension)")
			}
		}
	}
}

mncdump.main()
// swiftlint:enable type_name
