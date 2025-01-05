//
//  dump.swift
//  music-notation-dump
//
//  Created by Steven Woolgar on 2025-01-04.
//	Copyright © 2025 Steven Woolgar. All rights reserved.
//

import Foundation
import MusicNotation

// Walk the score and dump to requested formats
func dump(score: Score, graphviz: Bool, text: Bool) {
	print("===== Start dumping supplied score =====")

	if graphviz {
		dumpToGraphViz(score: score)
	}

	if text {
		dumpToText(score: score)
	}

	print("===== End dumping supplied score =====")
}

// Walk the score and dump to dot files (GraphViz)
func dumpToGraphViz(score: Score) {
}

// Walk the score and dump to dot files (GraphViz)
func dumpToText(score: Score) {
}
