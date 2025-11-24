import Testing
import UIKit
import AnimalListDomainInterface

@testable import AnimalListDomain

private enum TestError: Error, CustomStringConvertible {
    case prerequisiteFailed(String)
    var description: String {
        switch self {
        case .prerequisiteFailed(let reason):
            return "Test prerequisite failed: \(reason)"
        }
    }
}

struct AnimalListUseCaseTests {
    var useCase: AnimalListUsecase = AnimalListUseCaseImpl()
    
    @Test("동물 목록을 가져오는지 테스트")
    func test_fetch_animal_list_is_not_empty() async {
        let animals = await useCase.fetch()
        #expect(!animals.isEmpty)
    }
    
    @Test("가져온 동물 목록의 개수가 정확한지 테스트")
    func test_fetch_animal_list_has_correct_count() async {
        let animals = await useCase.fetch()
        #expect(animals.count == 200)
    }
    
        @Test("동물 속성이 올바르게 디코딩되었는지 테스트")
        func test_animal_properties_are_decoded_correctly() async throws {
            let animals = await useCase.fetch()
            
            guard let lion = animals.first(where: { $0.id == "lion" }) else {
                throw TestError.prerequisiteFailed("Lion not found in the list")
            }
    
            #expect(lion.id == "lion")
            #expect(lion.names.first(where: { $0.languageCode == "en" })?.name == "Lion")
            #expect(lion.names.first(where: { $0.languageCode == "ko" })?.name == "사자")
            
            #expect(lion.itemCategory2?.id == "mammal")
            #expect(lion.itemCategory2?.name == "Mammal")
            #expect(lion.itemCategory2?.names.first(where: { $0.languageCode == "en"})?.name == "Mammal")
            #expect(lion.itemCategory2?.names.first(where: { $0.languageCode == "ko"})?.name == "포유류")
        }
    
        @Test("모든 동물의 ID가 고유한지 테스트")
        func test_all_animal_ids_are_unique() async {
            let animals = await useCase.fetch()
            let idSet = Set(animals.map { $0.id })
            #expect(animals.count == idSet.count, "Duplicate IDs found in animal list")
        }
    }
struct AnimalImageTests {
    var useCase: AnimalListUsecase = AnimalListUseCaseImpl()
    
    @Test("동물 이미지가 번들에 존재하는지 테스트")
    func test_animal_image_exists() async throws {
        let animals = await useCase.fetch()
        guard let lion = animals.first(where: { $0.id == "lion" }) else {
            throw TestError.prerequisiteFailed("Lion not found")
        }
        
        let imageName = lion.imageNameStyle(.toy3d)
        #expect(imageName == "toy3d_lion.webp")
        
        guard let path = Bundle.module.path(forResource: imageName, ofType: nil) else {
            throw TestError.prerequisiteFailed("Image path for \(imageName ?? "nil") not found")
        }
        
        let image = UIImage(contentsOfFile: path)
        #expect(image != nil, "UIImage could not be created from path: \(path)")
    }
}
