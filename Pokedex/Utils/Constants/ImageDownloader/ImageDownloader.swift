//
//  ImageDownloader.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 02/07/22.
//

import UIKit

final class ImageDownloader {
    
    static let shared = ImageDownloader()
    let folderExtraPath = "pokemons"
    
    func loadImage(requestInfo: ImageDownloaderRequestInfo, completionHandler:@escaping (_ image: UIImage) -> Void) {
        let mappedName = String(requestInfo.id)

        if let image = loadImageFromDiskWith(fileName: mappedName) {
            completionHandler(image)
            return
        }

        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: requestInfo.url) {
                if let image = UIImage(data: data) {
                    completionHandler(image)
                }
            }
        }
    }
    
    
    func createDirectory(){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        guard let docURL = URL(string: documentsDirectory) else { return }
        let dataPath = docURL.appendingPathComponent(folderExtraPath)
        
        if !FileManager.default.fileExists(atPath: dataPath.absoluteString){
            do {
                try FileManager.default.createDirectory(atPath: dataPath.absoluteString, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription);
            }
        }
    }
    
    
    func loadImageFromDiskWith(fileName: String) -> UIImage? {
        
        var imageUrl: URL?
        
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let dirPath = paths.first {
            imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(folderExtraPath).appendingPathComponent(fileName)
            
            if let imageUrl = imageUrl {
                let image = UIImage(contentsOfFile: imageUrl.path)
                return image
            }
        }
        
        return nil
    }
    
    
    
    
}
