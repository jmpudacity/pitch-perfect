//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by JOSE MARIA PARRA on 26/04/15.
//  Copyright (c) 2015 jmp. All rights reserved.
//

//MODEL
import Foundation

class RecordedAudio: NSObject {
    
    //path
    var filePathUrl: NSURL!
    
    //title
    var title: String!
    
    override init() {
        filePathUrl = nil
        title = nil
    }
    
    init(filePathUrlIn: NSURL, titleIn: String) {
        
        filePathUrl = filePathUrlIn
        title = titleIn
    }

}