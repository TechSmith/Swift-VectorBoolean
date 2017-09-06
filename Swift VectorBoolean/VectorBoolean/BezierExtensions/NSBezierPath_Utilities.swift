//
//  NSBezierPath_Utilities.swift
//  Swift VectorBoolean for macOS
//
//  Based on NSBezierPath+Boolean - Created by Andrew Finnell on 5/31/11.
//  Copyright 2011 Fortunate Bear, LLC. All rights reserved.

//  Based on UIBezierPath_Boolean - Created by Leslie Titze on 2015-05-19.
//  Copyright (c) 2015 Leslie Titze. All rights reserved.

//  Created by April Noren on 2017-08-28.
//  Copyright (c) 2017 April Noren. All rights reserved.
//

import Foundation

struct NSBezierElement {
  var kind : CGPathElementType
  var point : CGPoint
  var controlPoints : [CGPoint]
}

let FBDebugPointSize = CGFloat(10.0)
let FBDebugSmallPointSize = CGFloat(3.0)

extension NSBezierPath {

  func fb_copyAttributesFrom(_ path: NSBezierPath) {
    self.lineWidth = path.lineWidth
    self.lineCapStyle = path.lineCapStyle
    self.lineJoinStyle = path.lineJoinStyle
    self.miterLimit = path.miterLimit
    self.flatness = path.flatness
  }

  static func circleAtPoint(_ point: CGPoint) -> NSBezierPath {

    let rect = CGRect(
      x: point.x - FBDebugPointSize * 0.5,
      y: point.y - FBDebugPointSize * 0.5,
      width: FBDebugPointSize,
      height: FBDebugPointSize);

    return NSBezierPath(ovalIn: rect)
  }

  static func rectAtPoint(_ point: CGPoint) -> NSBezierPath {

    let rect = CGRect(
      x: point.x - FBDebugPointSize * 0.5,
      y: point.y - FBDebugPointSize * 0.5,
      width: FBDebugPointSize,
      height: FBDebugPointSize);

    return NSBezierPath(rect: rect)
  }

  static func smallCircleAtPoint(_ point: CGPoint) -> NSBezierPath {

    let rect = CGRect(
      x: point.x - FBDebugSmallPointSize * 0.5,
      y: point.y - FBDebugSmallPointSize * 0.5,
      width: FBDebugSmallPointSize,
      height: FBDebugSmallPointSize);

    return NSBezierPath(ovalIn: rect)
  }

  static func smallRectAtPoint(_ point: CGPoint) -> NSBezierPath {

    let rect = CGRect(
      x: point.x - FBDebugSmallPointSize * 0.5,
      y: point.y - FBDebugSmallPointSize * 0.5,
      width: FBDebugSmallPointSize,
      height: FBDebugSmallPointSize);

    return NSBezierPath(rect: rect)
  }

  static func triangleAtPoint(_ point: CGPoint, direction tangent: CGPoint) -> NSBezierPath {

    let endPoint = FBAddPoint(point, point2: FBScalePoint(tangent, scale: FBDebugPointSize * 1.5))
    let normal1 = FBLineNormal(point, lineEnd: endPoint)
    let normal2 = CGPoint(x: -normal1.x, y: -normal1.y)
    let basePoint1 = FBAddPoint(point, point2: FBScalePoint(normal1, scale: FBDebugPointSize * 0.5))
    let basePoint2 = FBAddPoint(point, point2: FBScalePoint(normal2, scale: FBDebugPointSize * 0.5))
    let path = NSBezierPath()
    path.move(to: basePoint1)
    path.line(to: endPoint)
    path.line(to: basePoint2)
    path.line(to: basePoint1)
    path.close()

    return path
  }

   public var cgPath: CGPath {
      let path = CGMutablePath()
      var points = [CGPoint](repeating: .zero, count: 3)
      for i in 0 ..< self.elementCount {
         let type = self.element(at: i, associatedPoints: &points)
         switch type {
         case .moveToBezierPathElement: path.move(to: CGPoint(x: points[0].x, y: points[0].y) )
         case .lineToBezierPathElement: path.addLine(to: CGPoint(x: points[0].x, y: points[0].y) )
         case .curveToBezierPathElement: path.addCurve(      to: CGPoint(x: points[2].x, y: points[2].y),
                                                             control1: CGPoint(x: points[0].x, y: points[0].y),
                                                             control2: CGPoint(x: points[1].x, y: points[1].y) )
         case .closePathBezierPathElement: path.closeSubpath()
         }
      }
   return path
   }

}
