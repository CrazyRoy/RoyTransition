//
//  RoyThing.m
//  RoyTransitionAnimate
//
//  Created by ppdai-Roy on 2017/4/26.
//  Copyright © 2017年 ppdai-Roy. All rights reserved.
//

#import "RoyThing.h"

@implementation RoyThing

- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName overView:(NSString *)overStr {
    self = [super init];
    if(self) {
        _title = [title copy];
        _image = [UIImage imageNamed:imageName];
        _des = [overStr copy];
    }
    return self;
}

+ (NSArray *)exampleThings {
    return @[
             [[RoyThing alloc] initWithTitle:@"Thing 1" imageName:@"thing01.jpg" overView:@"Drumstick cow beef fatback turkey boudin. Meatball leberkas boudin hamburger pork belly fatback."],
             [[RoyThing alloc] initWithTitle:@"Thing 2" imageName:@"thing02.jpg" overView:@"Shank pastrami sirloin, sausage prosciutto spare ribs kielbasa tri-tip doner."],
             [[RoyThing alloc] initWithTitle:@"Thing 3" imageName:@"thing03.jpg" overView:@"Frankfurter cow filet mignon short loin ham hock salami meatloaf biltong andouille bresaola prosciutto."],
             [[RoyThing alloc] initWithTitle:@"Thing 4" imageName:@"thing04.jpg" overView:@"Pastrami sausage turkey shank shankle corned beef."],
             [[RoyThing alloc] initWithTitle:@"Thing 5" imageName:@"thing05.jpg" overView:@"Tri-tip short loin pork belly, pastrami biltong ball tip ham hock. Shoulder ribeye turducken shankle."]
            ];
}

@end
