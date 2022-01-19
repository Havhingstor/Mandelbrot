//
//  Renderer.swift
//  Mandelbrot-GUI
//
//  Created by Paul on 17.01.22.
//

import Foundation
import SwiftUI

public class Unit {
    public var group: Group
    private var upConnect: Bool = false, downConnect: Bool = false, leftConnect: Bool = false, rightConnect: Bool = false
    private var color: Color

    init(c: Color, up: Unit?, left: Unit?, x: Int, y: Int) {
        group = Group()

        color = c

        var l = false, u = false

        if let left = left {
            l = left.color == c
        }

        if let up = up {
            u = up.color == c
        }

        if l && !u {
            left!.connectRight()
            group = left!.group
            leftConnect = true
        } else if !l && u {
            up!.connectDown()
            group = up!.group
            upConnect = true
        } else if l && u {
            left!.connectRight()
            up!.connectDown()
            group = left!.group
            up!.group.changeGroup(g: group)
            leftConnect = true
            upConnect = true
        }
        group.addUnit(u: self)
    }

    public func connectRight() {
        rightConnect = true
    }

    public func connectDown() {
        downConnect = true
    }

    public var upConnectExternal: Bool { upConnect }
    public var downConnectExternal: Bool { downConnect }
    public var leftConnectExternal: Bool { leftConnect }
    public var rightConnectExternal: Bool { rightConnect }
    public var colorExternal: Color { color }

}

public class Group: CustomStringConvertible {
    private var groupID = UUID()

    private var units: [Unit] = []

    public func addUnit(u: Unit) {
        units.append(u)
    }

    public func changeGroup(g: Group) {
        if g.groupID != groupID {
            for unit in units {
                unit.group = g
                g.addUnit(u: unit)
            }
        }
    }

    public var description: String {
        groupID.uuidString
    }

    public var groupIDExternal: UUID {
        groupID
    }
}
