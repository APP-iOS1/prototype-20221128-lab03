//
//  IngredientStore.swift
//  whatShouldIEat_ProtoType
//
//  Created by 원태영 on 2022/11/09.
//

import SwiftUI

final class IngredientStore: ObservableObject {
    @Published var ingredients: [Ingredient] = ingredientData
	@Published var ingredientsDictionary: [String: [Ingredient]] = [:]
	
	let recipeManager = RecipeNetworkModel()
	
	let ingredientCategoryList: [String] = [
		"채소/과일",
		"버섯류",
		"육류/달걀",
		"콩류/견과류/두부류",
		"유제품",
		"김치",
		"가루류",
		"조미료/양념류/오일류",
		"민물/해산물",
		"음료류",
		"면류",
		"곡물/가공류",
		"기타"
	]
    
    let ingredientSaveWhereList : [Ingredient.SaveWhere] = [.refrigeration, .frozen, .roomTemperature]

	private func initDictionary() {
		for eachIngredients in ingredientData {
			let key = eachIngredients.ingredient
			
			if ingredientsDictionary[key] == nil {
				ingredientsDictionary.updateValue([eachIngredients],
												  forKey: key)
			}
		}
	}
	
	public func updateDictionary(eachIngredients: Ingredient) {
		let key = eachIngredients.ingredient
		if ingredientsDictionary[key] == nil {
			ingredientsDictionary.updateValue([eachIngredients], forKey: key)
		} else {
			ingredientsDictionary[key]?.append(eachIngredients)
		}
        print("---updateDictionary---")
        print(ingredientsDictionary)
        print("-------")
	}
    
    // 전달받은 재료의 id와 같은 재료를 배열에서 찾아서 인덱스를 반환하는 함수
    func getIngredientIndex(ingredient : Ingredient) -> Int {
        if let ingredients = ingredientsDictionary[ingredient.ingredient] {
            if !ingredients.isEmpty {
                return ingredients.enumerated().filter{$0.element.id == ingredient.id}.first!.offset
            }
        }
        return 0
    }
    
    // 현재 보유중인 모든 재료를 1차원으로 담아서 반환하는 함수
    func getMyIngredients() -> [Ingredient] {
        var ingredients : [Ingredient] = []
        for name in ingredientsDictionary {
            for ingredient in name.value {
                ingredients.append(ingredient)
            }
        }
        return ingredients
    }
    
    // 레시피에 있는 필요 재료 리스트를 내 보유 재료와 비교하여 모두 가지고 있는지 여부
    func isHaveAllNeedIngredients(needIngredientsName : [String]) -> Bool {
        let myIngredients = ["검은콩","메밀면","오이","방울토마토","땅콩","잣","참깨"] // 검은메밀면 조리가능에 뜨는지 확인하는 더미 데이터
//        let myIngredients = getMyIngredients().map{$0.ingredient} // 실제 코드
        return needIngredientsName.filter{name in
            return !myIngredients.contains(name)
        }.isEmpty
    }
    
    public func doSomething() {
        var ssub: Set<String> = Set<String>()
		
		// FIXME: 문자열을 우리가 원하는 방식대로 전처리하는 코드,
		/// 현재 모델 코드가 JSON 으로 예쁘게 파싱되지 않아서 각주 처리
		let temp = recipeManager.allRecipeData?.COOKRCP01.row.map { $0 }
//		temp.forEach { item in
//            item.split(separator: ",").forEach { sub in
//                let subsub = String(sub)
//                var subsubsub = subsub.contains("(") ? String(subsub.split(separator: "(").first!)
//                : subsub.contains(" ") ? String(subsub.split(separator: " ").first!) : subsub
//
//                // '재료', '다진' 단어 제외
//                subsubsub = subsubsub.replacingOccurrences(of: "재료", with: "")
//                    .replacingOccurrences(of: "다진", with: "")
//                    .replacingOccurrences(of: "\n", with: "")
//                    .trimmingCharacters(in: .whitespaces)
//                // 재료에 숫자 들어간 재료 제외
//                let regex = try! Regex("[0-9]") // Thanks for sj.
//                //
//                switch subsubsub {
//                case "후춧가루", "흰후추", "통후추":
//                    subsubsub = "후추"
//                case "녹말", "녹말가루":
//                    subsubsub = "녹말"
//                case "닭고기", "닭고기살":
//                    subsubsub = "닭고기"
//                case "들깨가루", "들깻가루":
//                    subsubsub = "들깨가루"
//                case "레디쉬", "무":
//                    subsubsub = "무"
//                case "배추잎", "배춧잎":
//                    subsubsub = "배추"
//                case "브로컬리", "브로콜리":
//                    subsubsub = "브로콜리"
//                case "새송이", "새송이버섯":
//                    subsubsub = "새송이버섯"
//                case "소고기", "소고기우둔살", "쇠고기", "쇠고기등심":
//                    subsubsub = "소고기"
//                case "저염간장", "저염":
//                    subsubsub = "저염간장"
//                case "파슬리", "파슬리가루":
//                    subsubsub = "파슬리"
//                case "표고버섯", "표고버섯 밑동":
//                    subsubsub = "표고버섯"
//                case "불린 당면":
//                    subsubsub = "당면"
//                case "산마":
//                    subsubsub = "꽁치"
//                default:
//                    break
//                }
//                if !subsubsub.contains(regex) {
//                    ssub.insert(subsubsub.trimmingCharacters(in: .whitespaces))
//                }
//            }
//        }
//        // for 끝
//        ssub.sorted().forEach { item in
//            print("\(item)")
//        }

    }
}

