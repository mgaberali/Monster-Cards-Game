
#import <Foundation/Foundation.h>

@interface HWinner : NSObject <NSCoding>

@property NSString *name;
@property NSString *email;
@property NSNumber *score;
@property NSString *winnerImage;

-(id)initWithName:(NSString *)fName email:(NSString *)fEmail score:(NSNumber *)fScore winnerImage:(NSString *)fImage;
-(void)encodeWithCoder:(NSCoder *)aCoder;
-(id)initWithCoder:(NSCoder *)aDecoder;


@end
