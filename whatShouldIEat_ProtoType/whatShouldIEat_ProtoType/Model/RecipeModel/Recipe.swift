//
//  Recipe.swift
//  whatShouldIEat_ProtoType
//
//  Created by 원태영 on 2022/11/09.
//

// JSON URL = http://openapi.foodsafetykorea.go.kr/api/6eb420202d8b439192d8/COOKRCP01/json/1/1000

import Foundation

final class RecipeNetworkModel: ObservableObject {
	private var firstLoad = false
	
	// 1000건을 요청하면 빈 문자열이 출력되는 이슈
	private let url = URL(string: "http://openapi.foodsafetykorea.go.kr/api/6eb420202d8b439192d8/COOKRCP01/json/1/10")!
	public var allRecipeData: RecipeAPI?
	
	private let session = URLSession(configuration: .default)
	private let decoder = JSONDecoder()
	
	public func parsing() async {
		if !firstLoad {
			do {
				let sessionResult = try await session.data(from: url)
				let parsedResult = try decoder.decode(RecipeAPI.self, from: sessionResult.0)
				allRecipeData = parsedResult
			} catch {
				print(error)
			}
			firstLoad = true
		}
	}
}

struct Recipe : Codable, Identifiable {
    var id: String
    var dish: String
    var description: String
    var ingredients: [String]
    var recipe: [String]
    var isBookmark: Bool
    var imageName: String
}

struct RecipeAPI: Codable {
	var COOKRCP01: RecipeDetails
}

struct RecipeDetails: Codable {
	var total_count: String
	var row: [EachRecipeDetail]
	var RESULT: RecipeParsingResult
}

struct RecipeParsingResult: Codable {
	var MSG: String
	var CODE: String
}

struct EachRecipeDetail: Codable, Hashable {
    
//    var id = UUID().uuidString
//    var isBookmark : Bool = false
    
	var RCP_PARTS_DTLS: String = ""
	var RCP_WAY2: String = ""
	var MANUAL_IMG20: String = ""
	var MANUAL20: String = ""
	var RCP_SEQ: String = ""
	var INFO_NA: String = ""
	var INFO_WGT: String = ""
	var INFO_PRO: String = ""
	var MANUAL_IMG13: String = ""
	var MANUAL_IMG14: String = ""
	var MANUAL_IMG15: String = ""
	var MANUAL_IMG16: String = ""
	var MANUAL_IMG10: String = ""
	var MANUAL_IMG11: String = ""
	var MANUAL_IMG12: String = ""
	var MANUAL_IMG17: String = ""
	var MANUAL_IMG18: String = ""
	var MANUAL_IMG19: String = ""
	var INFO_FAT: String = ""
	var HASH_TAG: String = ""
	var MANUAL_IMG02: String = ""
	var MANUAL_IMG03: String = ""
	var RCP_PAT2: String = ""
	var MANUAL_IMG04: String = ""
	var MANUAL_IMG05: String = ""
	var MANUAL_IMG01: String = ""
	var MANUAL01: String = ""
	var ATT_FILE_NO_MK: String = ""
	var MANUAL_IMG06: String = ""
	var MANUAL_IMG07: String = ""
	var MANUAL_IMG08: String = ""
	var MANUAL_IMG09: String = ""
	var MANUAL08: String = ""
	var MANUAL09: String = ""
	var MANUAL06: String = ""
	var MANUAL07: String = ""
	var MANUAL04: String = ""
	var MANUAL05: String = ""
	var MANUAL02: String = ""
	var MANUAL03: String = ""
	var ATT_FILE_NO_MAIN: String = ""
	var MANUAL11: String = ""
	var MANUAL12: String = ""
	var MANUAL10: String = ""
	var INFO_CAR: String = ""
	var MANUAL19: String = ""
	var INFO_ENG: String = ""
	var MANUAL17: String = ""
	var MANUAL18: String = ""
	var RCP_NM: String = ""
	var MANUAL15: String = ""
	var MANUAL16: String = ""
	var MANUAL13: String = ""
	var MANUAL14: String = ""
    
    var recipeInfoDetailList : [(img : String, description : String)] {
        return [
            (MANUAL_IMG01,MANUAL01),(MANUAL_IMG02,MANUAL02),(MANUAL_IMG03,MANUAL03),(MANUAL_IMG04,MANUAL04),
            (MANUAL_IMG05,MANUAL05),(MANUAL_IMG06,MANUAL06),(MANUAL_IMG07,MANUAL07),(MANUAL_IMG08,MANUAL08),
            (MANUAL_IMG19,MANUAL19),(MANUAL_IMG10,MANUAL10),(MANUAL_IMG11,MANUAL11),(MANUAL_IMG12,MANUAL12),
            (MANUAL_IMG13,MANUAL13),(MANUAL_IMG14,MANUAL14),(MANUAL_IMG15,MANUAL15),(MANUAL_IMG16,MANUAL16),
            (MANUAL_IMG17,MANUAL17),(MANUAL_IMG18,MANUAL18),(MANUAL_IMG19,MANUAL19),(MANUAL_IMG20,MANUAL20)
        ]
    }
    
}
