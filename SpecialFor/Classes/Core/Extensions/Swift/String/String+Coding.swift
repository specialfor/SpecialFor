//
//  StringExtensions.swift
//  Nynja
//
//  Created by Anton Makarov on 23.06.2017.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

extension String {
    // MARK: - Base64
    
    public var base64Encoded: String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    public var base64Decoded: String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    // MARK: - Percent encoding
    
    public var urlQueryEncoded: String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    public var urlFormEncoded: String? {
        let unreserved = "*-._ "
        var allowed = CharacterSet.alphanumerics
        allowed.insert(charactersIn: unreserved)
        let encoded = self.addingPercentEncoding(withAllowedCharacters: allowed)
        return encoded?.replacingOccurrences(of: " ", with: "+")
    }
    
    public var urlFormDecoded: String? {
        let encoded = self.replacingOccurrences(of: "+", with: "%20")
        return encoded.removingPercentEncoding
    }
    
    // MARK: - HTML
    
    public var htmlDecoded: String? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
            NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue,
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }
        
        return String(attributedString.string)
    }
}
