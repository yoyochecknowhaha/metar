//
//  MTShootModel.h
//  metar
//
//  Created by 关山第一渣男 on 2023/8/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTShootModel : NSObject

@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, copy, readwrite) NSString *ID;
@property (nonatomic, copy, readwrite) NSString *thumbnail;
@property (nonatomic, copy, readwrite) NSString *status;
@property (nonatomic, copy, readwrite) NSString *productLineType;
@property (nonatomic, copy, readwrite) NSString *memberUserId;
@property (nonatomic, copy, readwrite) NSString *createTime;

@property (nonatomic, assign, getter=isEditing) BOOL editing;
@property (nonatomic, assign, getter=isCanSelected) BOOL canSelected;
@property (nonatomic, assign, getter=isSelected) BOOL selected;

@end

NS_ASSUME_NONNULL_END
