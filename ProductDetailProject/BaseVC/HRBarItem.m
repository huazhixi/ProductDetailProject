

#import "HRBarItem.h"

@implementation HRBarItem

#pragma mark - ---------- Public Methods ----------

- (HRBarItem *(^)(CGRect))setupFrame {
    return ^(CGRect rect) {
        self.frame = rect;
        return self;
    };
}
- (HRBarItem *(^)(NSString *))setupTitle {
    return ^(NSString *title){
        [self setTitle:title forState:UIControlStateNormal];
        return self;
    };
}
- (HRBarItem *(^)(UIColor *))setupTitleColor {
    return ^(UIColor *color) {
        [self setTitleColor:color forState:UIControlStateNormal];
        return self;
    };
}
- (HRBarItem *(^)(UIFont *))setupFont {
    return ^(UIFont *font) {
        [self.titleLabel setFont:font];
        return self;
    };
}
- (HRBarItem *(^)(UIEdgeInsets))setupTitleEdgeInserts {
    return ^(UIEdgeInsets edge) {
        [self setTitleEdgeInsets:edge];
        [self sizeToFit];
        return self;
    };
}



@end
