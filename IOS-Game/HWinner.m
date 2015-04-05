
#import "HWinner.h"

@implementation HWinner

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_email forKey:@"email"];
    [aCoder encodeObject:_score forKey:@"score"];
    [aCoder encodeObject:_winnerImage forKey:@"winnerImage"];

}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super self];
    if (self) {
        _name = [aDecoder decodeObjectForKey:@"name"];
        _email = [aDecoder decodeObjectForKey:@"email"];
        _score = [aDecoder decodeObjectForKey:@"score"];
        _winnerImage = [aDecoder decodeObjectForKey:@"winnerImage"];
    }
    return  self;
}

-(id)initWithName:(NSString *)fName email:(NSString *)fEmail score:(NSNumber *)fScore winnerImage:(NSString *)fImage {
    if( self = [super init] )
    {
        _name = fName;
        _email = fEmail;
        _score = fScore;
        _winnerImage= fImage;
    }
    
    return self;
}
@end
