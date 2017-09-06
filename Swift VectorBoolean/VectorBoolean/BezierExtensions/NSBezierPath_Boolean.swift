//
//  NSBezierPath_Boolean.swift
//  Swift VectorBoolean for macOS
//
//  Based on NSBezierPath+Boolean - Created by Andrew Finnell on 5/31/11.
//  Copyright 2011 Fortunate Bear, LLC. All rights reserved.

//  Based on UIBezierPath_Boolean - Created by Leslie Titze on 2015-05-19.
//  Copyright (c) 2015 Leslie Titze. All rights reserved.

//  Created by April Noren on 2017-08-28.
//  Copyright (c) 2017 April Noren. All rights reserved.

extension NSBezierPath {

  func fb_union(_ path: NSBezierPath) -> NSBezierPath? {
    let thisGraph = FBBezierGraph(path: self)
    let otherGraph = FBBezierGraph(path: path)
    let resultGraph = thisGraph.unionWithBezierGraph(otherGraph)
    let result = resultGraph?.bezierPath
    result?.fb_copyAttributesFrom(self)
    return result
  }

  func fb_intersect(_ path: NSBezierPath) -> NSBezierPath {
    let thisGraph = FBBezierGraph(path: self)
    let otherGraph = FBBezierGraph(path: path)
    let result = thisGraph.intersectWithBezierGraph(otherGraph).bezierPath
    result.fb_copyAttributesFrom(self)
    return result
  }

  func fb_difference(_ path: NSBezierPath) -> NSBezierPath {
    let thisGraph = FBBezierGraph(path: self)
    let otherGraph = FBBezierGraph(path: path)
    let result = thisGraph.differenceWithBezierGraph(otherGraph).bezierPath
    result.fb_copyAttributesFrom(self)
    return result
  }

  func fb_xor(_ path: NSBezierPath) -> NSBezierPath {
    let thisGraph = FBBezierGraph(path: self)
    let otherGraph = FBBezierGraph(path: path)
    let result = thisGraph.xorWithBezierGraph(otherGraph).bezierPath
    result.fb_copyAttributesFrom(self)
    return result
  }

}
