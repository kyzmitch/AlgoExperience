//: Playground - noun: a place where people can play

import Cocoa

func divide(_ dividend: Double?, _ dividor: Double?) -> Double? {
    switch (dividend, dividor) {
    case (nil, _):
        return nil
    case (_, nil):
        return nil
    case let (v?, d?) where d != 0:
        return v / d
    case let (v?, d?):
        return nil
    }
}

divide(0, 2)
divide(2, 0)
divide(4, 2)
divide(3, 2)
divide(0, 0)
divide(nil, 2)
divide(2, nil)
divide(nil, nil)

