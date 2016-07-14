//
//  UtilsMacro.h
//  NQYoungCloud
//
//  Created by libo on 14-6-13.
//  Copyright (c) 2014年 NQ. All rights reserved.
//

#ifndef NQYoungCloud_UtilsMacro_h
#define NQYoungCloud_UtilsMacro_h

#define DEFAULTCENTER  [NSNotificationCenter defaultCenter]
#define USERDEFAULTS   [NSUserDefaults standardUserDefaults]

//navStudent.modalPresentationStyle = UIModalPresentationFormSheet;
// view 大小  540   620

/**
 图片
 */
#define PNGPATH(NAME)           [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"png"]
#define JPGPATH(NAME)           [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"jpg"]
#define PATH(NAME, EXT)         [[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]

#define PNGIMAGE(NAME)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
#define JPGIMAGE(NAME)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpg"]]
#define IMAGE(NAME, EXT)        [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]


/**
 颜色
 */
#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


/**
 系统版本
 */
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5_0 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320,568), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6Pus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define IOS_7 ([[[UIDevice currentDevice] systemVersion] intValue]>6 ? YES : NO)
#define IOS_8 ([[[UIDevice currentDevice] systemVersion] intValue]>7 ? YES : NO)

#define isPad                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/**
 当前语言
 */
#define CURRENTLANGUAGE         ([[NSLocale preferredLanguages] objectAtIndex:0])





// 本地化字符串
/** NSLocalizedString宏做的其实就是在当前bundle中查找资源文件名“Localizable.strings”(参数:键＋注释) */
#define LocalString(x, ...)     NSLocalizedString(x, nil)
/** NSLocalizedStringFromTable宏做的其实就是在当前bundle中查找资源文件名“xxx.strings”(参数:键＋文件名＋注释) */
#define AppLocalString(x, ...)  NSLocalizedStringFromTable(x, @"someName", nil)





//防止一个头文件被重复包含
#ifndef     COMDEF_H
#define     COMDEF_H
// 头文件内容
#endif


//设置线宽，如果是retina屏，lineWidth设为1,实际显示的宽度是2个像素
#define SETLINEWIDTH(ctx,w) CGContextSetLineWidth(ctx, w/[UIScreen mainScreen].scale)


//在ARC项目中使用 performSelector: withObject: 函数出现“performSelector may cause a leak because its selector is unknown”。
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)



#define USER_DEFAULT [NSUserDefaults standardUserDefaults]
#define USER_DEFAULT_KEY(element) [[NSUserDefaults standardUserDefaults] objectForKey:element]


#endif
