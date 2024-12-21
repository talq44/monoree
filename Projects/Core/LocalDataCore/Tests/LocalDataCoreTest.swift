import XCTest

import LocalDataCoreInterface
@testable import LocalDataCore

import RealmSwift

final class LocalDataCoreTests: XCTestCase {
    
    private var sut: LocalDataProtocolImpl!
    
    override func setUpWithError() throws {
        let testRealm = try makeRealm()
        self.sut = try LocalDataProtocolImpl(realm: testRealm)
    }
    
    func makeRealm() throws -> Realm {
        return try Realm(configuration: Realm.Configuration(
            inMemoryIdentifier: "testRealm"
        ))
    }

    override func tearDownWithError() throws {
        self.sut = nil
    }

    func test_given_평범_when_즐겨찾기추가_then_ID가반환되는가() throws {
        // given
        let id: Int = 1
        let isAdd: Bool = true
        let request = BookmarkUpdateRequestDTOImpl(
            id: id,
            isAdd: isAdd,
            name: "가상의 이름",
            avatarUrl: "URL"
        )
        
        // when
        let response: LocalDataCoreInterface.BookmarkUpdateResponseDTO
        do {
            response = try self.sut.patch_bookmarks(request: request)
        } catch {
            throw error
        }
        
        // then
        XCTAssertTrue(isAdd == response.isBookmarked && response.id == id)
    }
    
    func test_given_평범한데이터_when_즐겨찾기추가_후_목록갖고오기_then_목록이존재하는가() throws {
        // given
        let id: Int = 1
        let request = BookmarkUpdateRequestDTOImpl(
            id: id,
            isAdd: true,
            name: "가상의 이름",
            avatarUrl: "URL"
        )
        
        // when
        let response: LocalDataCoreInterface.BookmarkListResponseDTO
        do {
            _ = try self.sut.patch_bookmarks(request: request)
            response = try self.sut.get_bookmarks(
                request: BookmarkListRequestDTOImpl()
            )
        } catch {
            throw error
        }
        
        // then
        XCTAssertTrue(
            response.items.count > 0,
            "bookmark에 추가하면 목록을 돌려 받습니다."
        )
    }
    
    func test_given_즐겨찾기2개_when_즐겨찾기해제1_then_목록이하나인가() throws {
        // given
        let id01: Int = 1
        let id02: Int = 2
        let request01 = BookmarkUpdateRequestDTOImpl(
            id: id01,
            isAdd: true,
            name: "가상의 이름",
            avatarUrl: "URL"
        )
        let request02 = BookmarkUpdateRequestDTOImpl(
            id: id02,
            isAdd: true,
            name: "가상의 이름",
            avatarUrl: "URL"
        )
        let request03 = BookmarkUpdateRequestDTOImpl(
            id: id02,
            isAdd: false,
            name: "가상의 이름",
            avatarUrl: "URL"
        )
        
        // when
        let response: LocalDataCoreInterface.BookmarkListResponseDTO
        do {
            _ = try self.sut.patch_bookmarks(request: request01)
            _ = try self.sut.patch_bookmarks(request: request02)
            _ = try self.sut.patch_bookmarks(request: request03)
            response = try self.sut.get_bookmarks(
                request: BookmarkListRequestDTOImpl()
            )
        } catch {
            throw error
        }
        
        // then
        XCTAssertTrue(
            response.items.count == 1,
            "bookmark에 추가하면 목록을 돌려 받습니다."
        )
    }
    
    func test_given_없음_when_목록얻기_then_목록이비어있는가() throws {
        // given
        
        // when
        let response: LocalDataCoreInterface.BookmarkListResponseDTO
        do {
            response = try self.sut.get_bookmarks(
                request: BookmarkListRequestDTOImpl()
            )
        } catch {
            throw error
        }
        
        // then
        XCTAssertTrue(
            response.items.count == 0,
            "즐겨찾기 목록에 추가된 데이터가 없다면 값이 없어야 합니다."
        )
    }
    
}
