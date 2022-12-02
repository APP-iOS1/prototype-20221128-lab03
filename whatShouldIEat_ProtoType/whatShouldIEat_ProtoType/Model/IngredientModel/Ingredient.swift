//
//  Ingredient.swift
//  whatShouldIEat_ProtoType
//
//  Created by Roen White on 2022/11/08.
//

import Foundation

struct Ingredient : Codable, Identifiable, Hashable {
	public var id = UUID().uuidString
	public var icon: String
	public var category: String
	public var ingredient: String
	public var ishave: Bool
	
	// 각각의 감자를 따로 얼리도록 구현

    public var saveWhere : SaveWhere

	
	public var buyDate: Date?
	public var expiredDate: Date?
	public var addCounter: String?
	public var ingredientUnit: IngredientUnit?
    
    enum SaveWhere : String, Codable {
        case refrigeration = "냉장"
        case frozen = "냉동"
        case roomTemperature = "실온"
    }
}

struct NewIngredient: Identifiable {
	var id = UUID().uuidString
	var category: String
	var name: String
}

enum IngredientUnit: String, Identifiable, CaseIterable, Codable {
	case piece = "개",
		 g = "g(그램)",
		 Kg = "kg(킬로그램)",
		 mL = "ml(밀리리터)",
		 L = "L(리터)"
	var id: Self { self }
}


let categoryImageDB : [String : String] = [
    "채소/과일" : "vegetable",
    "버섯류" : "mushroom",
    "육류/달걀" : "meat",
    "콩류/견과류/두부류" : "beans",
    "유제품" : "dairy",
    "김치" : "kimchi",
    "가루류" : "powder",
    "조미료/양념류/오일류" : "condiments",
    "민물/해산물" : "seafood",
    "음료류" : "beverage",
    "면류" : "noodle",
    "곡물/가공류" : "grain",
    "기타" : "guitar"
]

// 각 음식 데이터를 DB화 해서 앱 시동시 foodDB를 초기화
var foodDb = [String: [String]]()

func initFoodDB() {
	foodDb = [
		"채소/과일": [
			"가지",
			"감자",
			"건미역",
			"검은콩",
			"곤약",
			"깻잎",
			"꽈리고추",
			"단호박",
			"당근",
			"대추",
			"대파",
			"레몬",
			"마늘",
			"마른 고추",
			"무",
			"미나리",
			"미니파프리카",
			"방울토마토",
			"배",
			"배추",
			"부추",
			"붉은 고추",
			"브로콜리",
			"블루베리",
			"비트",
			"사과",
			"샐러리",
			"생강",
			"숙주",
			"시금치",
			"쑥갓",
			"아욱",
			"애호박",
			"양파",
			"어린잎",
			"연근",
			"오렌지",
			"오이",
			"오이고추",
			"옥수수",
			"인삼",
			"잣",
			"참나물",
			"청경채",
			"청고추",
			"청양고추",
			"콩",
			"콩나물",
			"콩비지",
			"토란",
			"토마토",
			"파",
			"파프리카",
			"풋고추",
			"피망",
			"호박잎",
			"홀토마토",
			"홍고추"
		],
		
		"버섯류" : [
			"느타리버섯",
			"백일송이",
			"새송이버섯",
			"양송이",
			"표고버섯"
		],
		
		"육류/달걀" : [
			"달걀",
			"달걀노른자",
			"닭가슴살",
			"닭고기",
			"돈나물",
			"돼지고기",
			"메추리알",
			"베이컨",
			"삼겹살",
			"소고기",
			"오리고기",
			"통삼겹살",
			"통조림 햄"
		],
		
		"콩류/견과류/두부류" : [
			"강낭콩",
			"두부",
			"땅콩",
			"순두부",
			"아몬드",
			"호두",
		],
		
		"유제품" : [
			"모짜렐라치즈",
			"버터",
			"생크림",
			"연유",
			"우유",
			"치즈",
			"플레인요거트"
		],
		
		"김치" : [
			"김치",
			"물김치국물",
			"백김치"
		],
		
		"가루류" : [
			"강황가루",
			"겨자가루",
			"고춧가루",
			"녹말",
			"들깨가루",
			"밀가루",
			"빵가루",
			"전분가루",
			"찹쌀가루",
			"치자가루",
			"치즈가루",
			"카레가루",
			"콩가루",
			"함초가루"
		],
		
		"조미료/양념류/오일류" : [
			"가시오가피",
			"간장",
			"건바질",
			"고추장",
			"국간장",
			"꿀",
			"다시마",
			"된장",
			"레몬즙",
			"로즈마리",
			"맛간장",
			"발사믹소스",
			"배즙",
			"새우젓",
			"생강즙",
			"생강청",
			"설탕",
			"소금",
			"식용꽃",
			"식용유",
			"식초",
			"쌈장",
			"액젓",
			"어간장",
			"오가피",
			"올리브오일",
			"월계수잎",
			"유자청",
			"육수",
			"저염간장",
			"참기름",
			"참깨",
			"통깨",
			"튀김기름",
			"파슬리",
			"함초",
			"함초소금",
			"후추"
		],
		
		"민물/해산물" : [
			"건새우",
			"광어",
			"굴",
			"꽁치",
			"멸치",
			"바지락",
			"삼치",
			"새우",
			"오징어",
			"우렁이",
			"전복",
			"주꾸미",
			"칵테일새우",
			"해초",
			"황태채"
		],
		
		"음료류" : [
			"물",
			"정종",
			"청주",
			"커피",
			"코코넛밀크",
			"탄산수",
			"후르츠칵테일"
		],
		
		"면류" : [
			"메밀면",
			"당면",
			"펜네"
		],
		
		"곡물/가공류" : [
			"귀리밥",
			"떡",
			"실곤약",
			"쌀",
			"쌀겨",
			"조랭이떡",
			"찹쌀"
		],
		
		"기타" : [
			
		]
	]
}
