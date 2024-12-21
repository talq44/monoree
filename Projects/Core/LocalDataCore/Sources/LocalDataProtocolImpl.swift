import Foundation

import LocalDataCoreInterface

import RealmSwift

class LocalDataProtocolImpl: LocalDataProtocol {
    private var realm: Realm

    init(realm: Realm? = nil) {
        // 전달된 Realm이 없으면 기본 Realm 사용
        guard let realm else {
            self.realm = try! Realm()
            return
        }
        self.realm = realm
    }
    
    private func getRealmDatas<T: RealmFetchable>(
        type: T.Type
    ) -> [T] {
        let realmData = realm.objects(T.self)
        return Array(realmData)
    }
    
    private func postRealmDatas<T: RealmSwift.Object>(
        _ data: [T]
    ) throws {
        do {
            try realm.write {
                realm.add(data, update: .modified)
            }
        } catch {
            throw error
        }
    }
    
    private func deleteRealmData<T: Object>(
        ofType type: T.Type,
        withPrimaryKey key: Any
    ) throws {
        do {
            // 객체를 특정 primary key로 가져오기
            guard let objectToDelete = realm.object(
                ofType: type,
                forPrimaryKey: key
            ) else {
                return
            }
            
            try realm.write {
                realm.delete(objectToDelete)
            }
            
        } catch {
            throw error
        }
    }
    
    func get_bookmarks(
        request: any LocalDataCoreInterface.BookmarkListRequestDTO
    ) -> any LocalDataCoreInterface.BookmarkListResponseDTO {
        let items = self.getRealmDatas(type: BookmarkItemDTOImpl.self)
        return BookmarkListResponseDTOImpl(items: items)
    }
    
    func patch_bookmarks(
        request: LocalDataCoreInterface.BookmarkUpdateRequestDTO
    ) throws -> LocalDataCoreInterface.BookmarkUpdateResponseDTO {
        do {
            if request.isAdd {
                let item = BookmarkItemDTOImpl()
                item.id = request.id
                item.avatarUrl = request.avatarUrl
                item.name = request.name
                try self.postRealmDatas([item])
                
            } else {
                try self.deleteRealmData(
                    ofType: BookmarkItemDTOImpl.self,
                    withPrimaryKey: request.id
                )
            }
        } catch {
            throw error
        }
        
        return BookmarkUpdateResponseDTOImpl(
            id: request.id,
            isBookmarked: request.isAdd
        )
    }
}
