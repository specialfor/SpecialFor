//
//  LengthValidator.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 11/26/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

public final class LengthValidator: MTIValidator {
    private let length: Length
    private let shouldTrim: Bool
    
    public init(length: Length, shouldTrim: Bool = true) {
        self.length = length
        self.shouldTrim = shouldTrim
    }
    
    public func validate(text: String) -> InputInfo? {
        let text = shouldTrim ? text.trimmingCharacters(in: .whitespacesAndNewlines) : text
        
        if let max = length.max, text.count > max.value {
            return makeInputInfo(with: max)
        } else if let min = length.min, text.count < min.value {
            return makeInputInfo(with: min)
        }
        
        return nil
    }
    
    private func makeInputInfo(with length: Length) -> InputInfo {
        return InputInfo(text: length.message, kind: .warning)
    }
}

extension LengthValidator {
    public enum Length {
        public typealias MessageProvider = (Int) -> String
        
        case min(Int, MessageProvider)
        case max(Int, MessageProvider)
        indirect case both(max: Length, min: Length)
        
        public var min: Length? {
            switch self {
            case .min:
                return self
            case let .both(max: _, min: length):
                return length
            default:
                return nil
            }
        }
        
        public var max: Length? {
            switch self {
            case .max:
                return self
            case let .both(max: length, min: _):
                return length
            default:
                return nil
            }
        }
        
        public var message: String {
            switch self {
            case let .min(value, provider):
                return provider(value)
            case let .max(value, provider):
                return provider(value)
            default:
                fatalError("Should not be called")
            }
        }
        
        public var value: Int {
            switch self {
            case let .min(value, _):
                return value
            case let .max(value, _):
                return value
            default:
                fatalError("Should not be called")
            }
        }
    }
}
