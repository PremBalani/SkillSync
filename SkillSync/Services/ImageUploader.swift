//
//  ImageUploader.swift
//  SkillSync
//
//  Created by Prem Balani on 3/7/24.
//

import Firebase
import FirebaseStorage
import UIKit
import PDFKit

struct ImageUploader {
    static func uploadImage(image: UIImage) async throws -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return nil }
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        do {
            let _ = try await ref.putDataAsync(imageData)
            let url = try await ref.downloadURL()
            return url.absoluteString
            
        } catch {
            print("DEBUG: Failed uploading data with error \(error)")
            return nil
        }
    }
    
    static func uploadPDF(data: Data) async throws -> String? {
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/transcripts/\(filename)")
        do {
            let _ = try await ref.putDataAsync(data)
            let url = try await ref.downloadURL()
            return url.absoluteString
            
        } catch {
            print("DEBUG: Failed uploading data with error \(error)")
            return nil
        }
    }
}
