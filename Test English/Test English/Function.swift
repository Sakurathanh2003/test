//
//  Function.swift
//  Test English
//
//  Created by Vu Thanh on 20/12/2021.
//
import UIKit
import Foundation
import AVFoundation

func sound(_ word: String){
    let talk = AVSpeechSynthesizer()
    
    let speakWord = AVSpeechUtterance(string: word)
    speakWord.voice = AVSpeechSynthesisVoice(language: "en-GB")
    speakWord.rate = 0.5
    
    talk.speak(speakWord)
}

func ChuyenThanhSo(_ kitu: String) -> Int{
    var ans = Unicode.Scalar(kitu)
    return Int(ans!.value)
}





