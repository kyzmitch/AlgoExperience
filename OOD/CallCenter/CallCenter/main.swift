//
//  main.swift
//  CallCenter
//
//  Created by admin on 23/01/2018.
//  Copyright © 2018 kyzmitch. All rights reserved.
//

import Foundation

let head = Director()
let callCenter = ConcreteCallCenter(callCenterHead: head)

func dispatchCall(_ callId: UInt) {
    let call = IncomingCall(identity: callId)
    callCenter.handleIncoming(call: call)
}

for _ in 0..<10 {
    callCenter.respondents.append(Respondent())
}

for _ in 0..<3 {
    callCenter.managers.append(Manager())
}


for i in 0..<10 {
    dispatchCall(UInt(i))
}

while true {
    
}
