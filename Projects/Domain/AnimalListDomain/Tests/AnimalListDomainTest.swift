import Testing
import UIKit
import AnimalListDomainInterface

@testable import AnimalListDomain

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
        // Assuming animal.txt has 151 lines based on previous context
        #expect(animals.count == 149)
    }

    @Test("동물 속성이 올바르게 디코딩되었는지 테스트")
    func test_animal_properties_are_decoded_correctly() async {
        let animals = await useCase.fetch()
        
        guard let lion = animals.first(where: { $0.id == "lion" }) else {
            #expect(false, "Lion not found in the list")
            return
        }

        #expect(lion.id == "lion")
        #expect(lion.names.first(where: { $0.languageCode == "en" })?.name == "lion")
    }
}

struct AnimalImageTests {
    var useCase: AnimalListUsecase = AnimalListUseCaseImpl()

    @Test("동물 이미지가 번들에 존재하는지 테스트")
    func test_animal_image_exists() async {
        let animals = await useCase.fetch()
        guard let lion = animals.first(where: { $0.id == "lion" }) else {
            #expect(false, "Lion not found")
            return
        }

        let imageName = lion.imageNameStyle(.toy3d)
        #expect(imageName == "toy3d_lion.webp")

        guard let path = Bundle.module.path(forResource: imageName, ofType: nil) else {
            #expect(false, "Image path for \(imageName ?? "nil") not found")
            return
        }

        let image = UIImage(contentsOfFile: path)
        #expect(image != nil, "UIImage could not be created from path: \(path)")
    }
}
