//
//  PostProvider.swift
//  Photogram
//
//  Created by Roman Gorshkov on 10.06.2021.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol FBPostProviderProtocol: BaseProviderProtocol {
    func getCollection(completion: @escaping (_ collection: [Post], _ error: Error?) -> Void)
    func create(post: Post, completion: @escaping (_ error: Error?) -> Void)
}

final class FBPostProvider: FBPostProviderProtocol {
    
    private let db = Firestore.firestore()
    var collectionName = "posts"
    
    func getCollection(completion: @escaping ([Post], Error?) -> Void) {
        db.collection(collectionName)
            .order(by: Post.Fields.createdAt.rawValue, descending: true)
            .getDocuments { snapshot, error in
                guard nil == error else { completion([], error!); return }
                guard let snapshot = snapshot else { completion([], nil); return }
                let collection = snapshot.documents.compactMap { document -> Post? in
                    guard var post = try? document.data(as: Post.self) else { return nil }
                    guard let imageName = post.imageName else { return post }
                    post.reference = Storage.storage().reference().child("images/\(imageName)")
                    return post
                }
                completion(collection, nil)
        }
    }
    
    func create(post: Post, completion: @escaping (Error?) -> Void) {
        var dictPost = [String: Any]()
        dictPost["user_id"] = post.imageName
        dictPost["title"] = post.title
        dictPost["created_at"] = post.createdAt
        dictPost["image_name"] = post.imageName
        db.collection(collectionName).addDocument(data: dictPost) { (error) in
            completion(error)
        }
    }
    
    
    
}
