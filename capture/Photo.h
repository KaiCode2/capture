//
//  Photo.h
//  capture
//
//  Created by kai don aldag on 2014-08-22.
//  Copyright (c) 2014 kai.don.aldag. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Photo : NSManagedObject

@property (nonatomic, retain) NSData * photoImage;
@property (nonatomic, retain) NSString * photoTitle;
@property (nonatomic, retain) NSString * photoDescription;

@end
