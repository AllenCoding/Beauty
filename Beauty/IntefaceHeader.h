//
//  IntefaceHeader.h
//  Beauty
//
//  Created by LiuYong on 2018/6/4.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#ifndef IntefaceHeader_h
#define IntefaceHeader_h

#define  mainUrl  @"http://gank.io/api/"
#define dayUrl @"http://gank.io/api/day/history"
#define submitUrl @"https://gank.io/api/add2gank"

/*
 1.首页数据
 http://gank.io/api/data/数据类型/请求个数/第几页
 类型:福利 | Android | iOS | 休息视频 | 拓展资源 | 前端 | all
 个数：10
 页码：1
 eg: http://gank.io/api/data/福利/10/1
 */

/*
 2.每日数据： http://gank.io/api/day/年/月/日
 例：
 http://gank.io/api/day/2015/08/06
 随机数据：http://gank.io/api/random/data/分类/个数

 */
/*
 3.数据类型：福利 | Android | iOS | 休息视频 | 拓展资源 | 前端
 个数： 数字，大于0
 例：
 http://gank.io/api/random/data/Android/20
 */










#endif /* IntefaceHeader_h */




