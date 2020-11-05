//
//  DJSaveDataTools.swift
//  TestApp
//
//  Created by mac on 2020/11/5.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import SQLite

typealias SQliteGetDataBlock = (_ values:[[String:String]]?)->Void
class DJSQliteTools {
    
    
    //获取connection
    static func getDBConnect()->Connection?{
        let documentPaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentPath = documentPaths[0]
        var dataSavePath = documentPath + "/SQliteData/"
        
        try? FileManager.default.createDirectory(atPath: dataSavePath, withIntermediateDirectories: true, attributes: nil)
        dataSavePath += "db.sqlite3"
        
        print("数据库地址: \n\(dataSavePath)")
        var conn:Connection?
        
        do {
            conn = try Connection.init(dataSavePath)
            conn?.busyTimeout = 5
            conn?.busyHandler({ tries in
                if tries >= 3 {
                    return false
                }
                return true
            })
        } catch _ {
            conn = nil
        }
        return conn
    }
    
    
    
    //保存
    static func saveData(_ str:String?){
        guard let value = str,value.count > 0 else {
            return
        }
        guard let timeStr = self.getCurrentTime() else {
            return
        }
        guard let conn = DJSQliteTools.getDBConnect() else {
            return
        }
        let userInfoTable = Table("postListTable")
        let userIdColumn = Expression<String>("id")
        let userinfoColumn = Expression<String>("value")
        try? conn.run(userInfoTable.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (t) in
            t.column(userIdColumn, primaryKey: true)
            t.column(userinfoColumn)
        }))
        
        let insert = userInfoTable.insert(userIdColumn <- timeStr, userinfoColumn <- value)
        try? conn.run(insert)
        
    }
    
    
    //获取所有数据列表
    static func getAllListData(_ block:SQliteGetDataBlock){
       guard let conn = DJSQliteTools.getDBConnect() else {
            block(nil)
            return
        }
        
        let userInfoTable = Table("postListTable")
        let userIdColumn = Expression<String>("id")
        let userinfoColumn = Expression<String>("value")
        
        
        try? conn.run(userInfoTable.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (t) in
            t.column(userIdColumn, primaryKey: true)
            t.column(userinfoColumn)
        }))
        
        //查询
        
        //let query = userInfoTable.filter(userIdColumn.count > 0)
        let query = userInfoTable.select([userIdColumn,userinfoColumn])
        guard let items = try? conn.prepare(query) else {
            block(nil)
            return
        }
        var datas:[[String:String]] = []
        for item in items{
            datas.append([item[userIdColumn]:item[userinfoColumn]])
        }
        block(datas)
    }
    
    
    static func getCurrentTime()->String?{
        let date = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyy-MM-dd HH:mm:ss"
        guard  let strNowTime = timeFormatter.string(from: date) as String? else {
            return nil
        }
        return strNowTime
        
    }
}
