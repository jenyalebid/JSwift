//
//  Data.swift
//  JSwift
//
//  Created by Jenya Lebid on 9/3/24.
//

import Foundation
import ImageIO
import UIKit

public extension Data {
    
    static func fetch(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return data
    }
    
    func downsampleImage(targetSize: CGSize, maxFileSizeKB: Int = Int.max) -> Data? {
        // Create an image source from the data
        guard let imageSource = CGImageSourceCreateWithData(self as CFData, nil) else {
            return nil
        }
        
        // Define options for downsampling
        let maxDimension = Swift.max(targetSize.width, targetSize.height)
        let options: [CFString: Any] = [
            kCGImageSourceThumbnailMaxPixelSize: maxDimension,
            kCGImageSourceCreateThumbnailFromImageAlways: true
        ]
        
        // Create a downsampled image
        guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options as CFDictionary) else {
            return nil
        }
        
        // Convert the downsampled CGImage to JPEG data with varying compression quality
        var compressionQuality: CGFloat = 1.0
        var outputData: Data? = nil

        repeat {
            // Adjust compression quality
            outputData = UIImage(cgImage: downsampledImage).jpegData(compressionQuality: compressionQuality)
            compressionQuality -= 0.1
        } while (outputData?.count ?? Int.max) > maxFileSizeKB * 1024 && compressionQuality > 0.1

        // Final check if data is within the size limit
        if let data = outputData, data.count <= maxFileSizeKB * 1024 {
            return data
        } else {
            // If still too large, try downsampling to an even smaller target size
            let smallerSize = CGSize(width: targetSize.width * 0.8, height: targetSize.height * 0.8)
            return self.downsampleImage(targetSize: smallerSize, maxFileSizeKB: maxFileSizeKB)
        }
    }
}
