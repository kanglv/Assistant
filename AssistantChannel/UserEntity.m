//
//  UserEntity.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/2/26.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "UserEntity.h"

@implementation UserEntity

static UserEntity * _sharedInstance = nil;

+ (id)sharedInstance
{
    static dispatch_once_t p = 0;
    dispatch_once(&p, ^{
        
        NSData *userData=[[NSUserDefaults standardUserDefaults] objectForKey:@"UserEntity"];
        if (userData) {
            _sharedInstance = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        }else{
            _sharedInstance = [[UserEntity alloc] init];
        }
    });
    return _sharedInstance;
}

- (void) deepCopy:(UserEntity *)sender
{
    _sharedInstance.success = [sender.success mutableCopy];
    _sharedInstance.msg = [sender.msg mutableCopy];
    _sharedInstance.uid = [sender.uid mutableCopy];
    _sharedInstance.nickname = [sender.nickname mutableCopy];
    _sharedInstance.username = [sender.username mutableCopy];
    _sharedInstance.sex = [sender.sex mutableCopy];
    _sharedInstance.mobile = [sender.mobile mutableCopy];
    _sharedInstance.dep_id = [sender.dep_id mutableCopy];
    _sharedInstance.dep_code = [sender.dep_code mutableCopy];
    _sharedInstance.roles = [sender.roles mutableCopy];
    _sharedInstance.sn = [sender.sn mutableCopy];
    _sharedInstance.status = [sender.status mutableCopy];
    _sharedInstance.dep_name = [sender.dep_name mutableCopy];
    _sharedInstance.role_name = [sender.role_name mutableCopy];
}

-(void)update:(NSDictionary*)attributes
{
    NSNumber *state = [attributes valueForKeyPath:@"success"];
    self.success= [NSString stringWithFormat:@"%d", [state intValue]];
    
   
    self.msg = [attributes valueForKeyPath:@"msg"];
//
//    self.uid = [attributes valueForKeyPath:@"weather"];
    
    NSDictionary *content = [attributes valueForKey:@"data"];
    
    if (content != nil) {
        self.uid = [content valueForKeyPath:@"uid"];
        self.nickname = [content valueForKeyPath:@"nickname"];
        self.username = [content valueForKeyPath:@"username"];
        self.sex = [content valueForKeyPath:@"sex"];
        self.mobile = [content valueForKeyPath:@"mobile"];
        self.dep_id = [content valueForKeyPath:@"dep_id"];
        self.dep_code = [content valueForKeyPath:@"dep_code"];
        self.sn = [content valueForKey:@"sn"];
        self.status = [content valueForKey:@"status"];
        self.role_name = [content valueForKey:@"role_name"];
        self.dep_name = [content valueForKey:@"dep_name"];
        self.roles = [content valueForKey:@"roles"];
    }
}

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    [self update:attributes];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.success forKey:@"success"];
    [encoder encodeObject:self.msg forKey:@"msg"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.nickname forKey:@"nickname"];
    [encoder encodeObject:self.username forKey:@"username"];
    [encoder encodeObject:self.sex forKey:@"sex"];
    [encoder encodeObject:self.mobile forKey:@"mobile"];
    [encoder encodeObject:self.dep_id forKey:@"dep_id"];
    [encoder encodeObject:self.dep_code forKey:@"dep_code"];
    [encoder encodeObject:self.roles forKey:@"roles"];
    [encoder encodeObject:self.status forKey:@"status"];
    [encoder encodeObject:self.sn forKey:@"sn"];
    [encoder encodeObject:self.role_name forKey:@"role_name"];
    [encoder encodeObject:self.dep_name forKey:@"dep_name"];
    
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if(self = [super init]) {
        self.success = [decoder decodeObjectForKey:@"success"];
        self.msg = [decoder decodeObjectForKey:@"msg"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.nickname = [decoder decodeObjectForKey:@"nickname"];
        self.username = [decoder decodeObjectForKey:@"username"];
        self.sex = [decoder decodeObjectForKey:@"sex"];
        self.mobile = [decoder decodeObjectForKey:@"mobile"];
        self.dep_id = [decoder decodeObjectForKey:@"dep_id"];
        self.dep_code = [decoder decodeObjectForKey:@"dep_code"];
        self.roles = [decoder decodeObjectForKey:@"roles"];
        self.status = [decoder decodeObjectForKey:@"status"];
        self.dep_name = [decoder decodeObjectForKey:@"dep_name"];
        self.sn = [decoder decodeObjectForKey:@"sn"];
        self.role_name = [decoder decodeObjectForKey:@"role_name"];
    }
    return  self;
}

@end
