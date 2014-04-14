//
//  Common.h
//  BookReader
//
//  Created by yuan on 2014/04/02.
//  Copyright (c) 2014年 Yuan. All rights reserved.
//

#ifndef BookReader_Common_h
#define BookReader_Common_h

#define DocumentsDirectory  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define LibraryDirectory    [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]
#define CachesDirectory     [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
#define DataDirectory       [LibraryDirectory stringByAppendingPathComponent:@"Data"]

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SystemVersionGreaterOrEqualThan(version) ([[[UIDevice currentDevice] systemVersion] floatValue] >= version)

#ifndef BRLog
#if DEBUG
#define BRLog(fmt, ...)    NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__);
#else
#define BRLog(fmt, ...)
#endif
#endif

#endif
