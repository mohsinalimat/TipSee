//
//  TipC-Exts.swift
//  Pods-TipC_Example
//
//  Created by Farshad Jahanmanesh on 7/18/19.
//
import UIKit
public class HintPointerManager {
    public var pointer : HintPointer
    public private(set) var hints : [HintPointer.HintItem]
    public var latestHint : HintPointer.HintItem?
    public var onBubbleTap: ((HintPointer.HintItem?) -> Void)? {
        didSet{
            pointer.onBubbleTap = self.onBubbleTap
        }
    }
    public var onDimTap : ((HintPointer.HintItem?) -> Void)? {
        didSet{
            pointer.onDimTap = self.onDimTap
        }
    }
    public var currentIndex : Int? {
        didSet {
            guard let index = currentIndex else {
                self.pointer.finish()
                return
            }
            latestHint = hints[index]
            self.pointer.show(item: latestHint!)
        }
    }
    
    /// creates a slider manager.
    /// - Warning: the HintPointer object that should be passed in in init, is accessed with strong reference so you do not need to keep it strong too
    /// - Parameters:
    ///   - pointer: hint pointer object
    ///   - items: items
    public init(on window : UIWindow,with options: HintPointer.Options) {
        self.pointer = HintPointer(on: window)
        self.pointer.options(options)
        self.hints = [HintPointer.HintItem]()
    }
    public func add(new view : HintTarget,text string: String, with bubbleOption: HintPointer.Options.Bubble?){
        self.hints.append(pointer.createItem(for: view,text: string, with: bubbleOption))
    }
    public func add(new item: HintPointer.HintItem){
        self.hints.append(item)
    }
    /// shows the next hint
    public func next(){
        guard let current = latestHint,let currentIndex = hints.firstIndex(of: current) else {
            if !hints.isEmpty{
                self.currentIndex = 0
            }
            return
        }
        let next  = currentIndex+1
        if next < hints.count {
            self.currentIndex = next
        }
    }
    
    // shows the previous hint
    public func previous(){
        guard let current = latestHint,let currentIndex = hints.firstIndex(of: current) else {
            return
        }
        let previous  = currentIndex-1
        if previous >= 0 {
            self.currentIndex = previous
        }
    }
    
    public func finish(){
        pointer.finish()
    }
}



