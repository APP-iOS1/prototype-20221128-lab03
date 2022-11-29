//
//  Ingredient.swift
//  whatShouldIEat_ProtoType
//
//  Created by Roen White on 2022/11/08.
//

import Foundation

struct Ingredient : Codable, Identifiable {
	var id = UUID().uuidString
	var icon: String
    var category: String
    var ingredient: String
    var ishave: Bool
	// 각각의 감자를 따로 얼리도록 구현
    var isFrozen: Bool
	
	// 재료를 추가한 날짜
	// 냉장했다가 냉동으로 옮기는 경우?
	var date: Date {
		return Date.now
	}
	
	// 기본 유통기한 5일?
	var defaultDeadDate: Date {
		return Calendar.current.date(byAdding: .day, value: 5, to: date)!
	}
}


