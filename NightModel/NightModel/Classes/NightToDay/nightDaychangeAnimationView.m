
#import "nightDaychangeAnimationView.h"
#import "Masonry.h"

#define screenH   ([UIScreen mainScreen].bounds.size.height)
#define screenW   ([UIScreen mainScreen].bounds.size.width)

@interface nightDaychangeAnimationView ()
@property (strong, nonatomic)  UIImageView *sunOrMoon;
@property (strong, nonatomic)  UIImageView *img4;
@property (strong, nonatomic)  UIImageView *img3;
@property (strong, nonatomic)  UIImageView *img2;
@property (strong, nonatomic)  UIImageView *img1;
@property (strong, nonatomic)  UIImageView *bg;

@property (nonatomic, assign) CGFloat move1;
@property (nonatomic, assign) CGFloat move2;
@property (nonatomic, assign) CGFloat move3;
@property (nonatomic, assign) CGFloat move4;
@property (nonatomic, assign) CGFloat moveSunX;
@property (nonatomic, assign) CGFloat moveSunY;

@end

@implementation nightDaychangeAnimationView

- (instancetype)init{
    if (self = [super init]) {
        [self setupImageView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
    }
    return self;
}

- (void)setupImageView{
    CGFloat w = 375;
    CGFloat h = 667;
    if (screenW > screenH) {
        w = 667;
        h = 375;
    }
    
    _move1 = screenH * 73.5/h;
    _move2 = screenH * 36/h;
    _move3 = screenH * 23.5/h;
    _move4 = screenH * 15/h;
//    _moveSunX = (screenW - _sunOrMoon.width) / 2 + 30;
    _moveSunY = screenH * 118/h;

    [self addSubview:self.bg];
    [self addSubview:self.sunOrMoon];
    [self addSubview:self.img4];
    [self addSubview:self.img3];
    [self addSubview:self.img2];
    [self addSubview:self.img1];
    
    [self.bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.left.right.mas_equalTo(self);
    }];
    
    [self.sunOrMoon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(@352);
        make.centerX.mas_equalTo(self).offset(-30);
        make.bottom.mas_equalTo(self).offset(85);
    }];
    
    [self.img4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(-5.5);
        make.height.mas_equalTo(@204.5);
    }];
    
    [self.img3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(-71.5);
        make.height.mas_equalTo(@94.5);
    }];
    
    [self.img2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(-18.5);
        make.height.mas_equalTo(@173.5);
    }];
    
    [self.img1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(17.5);
        make.height.mas_equalTo(@180.5);
    }];
}

- (void)setIsNightToDay:(BOOL)isNightToDay{
    if (isNightToDay) {
        self.sunOrMoon.image = [self setImageFromFile:@"night_change_to_day_sun"];
        self.bg.image = [self setImageFromFile:@"nightTodaybg"];
        self.img1.image = [self setImageFromFile:@"nightToday1"];
        self.img2.image = [self setImageFromFile:@"nightToday2"];
        self.img3.image = [self setImageFromFile:@"nightToday3"];
        self.img4.image = [self setImageFromFile:@"nightToday4"];
    }else{
        self.sunOrMoon.image = [self setImageFromFile:@"day_change_to_night_moon"];
        self.bg.image = [self setImageFromFile:@"dayTonightbg"];
        self.img1.image = [self setImageFromFile:@"dayTonight1"];
        self.img2.image = [self setImageFromFile:@"dayTonight2"];
        self.img3.image = [self setImageFromFile:@"dayTonight3"];
        self.img4.image = [self setImageFromFile:@"dayTonight4"];
    }
}

- (void)setImgYFor5{
    _move1 += 20;
    _move2 += 20;
    _move3 += 20;
    _move4 += 20;
}

- (void)animationWithTime:(NSTimeInterval)t{
    CGAffineTransform transformSun = CGAffineTransformTranslate(_sunOrMoon.transform, 70, -_moveSunY);
    CGAffineTransform transformImg1 = CGAffineTransformTranslate(_img1.transform, 0, _move1);
    CGAffineTransform transformImg2 = CGAffineTransformTranslate(_img2.transform, 0, _move2);
    CGAffineTransform transformImg3 = CGAffineTransformTranslate(_img3.transform, 0, _move3);
    CGAffineTransform transformImg4 = CGAffineTransformTranslate(_img4.transform, 0, _move4);
    
    [UIView animateWithDuration:t animations:^{
        _sunOrMoon.transform = transformSun;
        _img1.transform = transformImg1;
        _img2.transform = transformImg2;
        _img3.transform = transformImg3;
        _img4.transform = transformImg4;
    }];
}

- (UIImage *)setImageFromFile:(NSString *)name{
    NSString *strResourcesBundle = [[NSBundle bundleForClass:[self class]] pathForResource:@"NightModel" ofType:@"bundle"];
    
    return [UIImage imageWithContentsOfFile:[[NSBundle bundleWithPath:strResourcesBundle] pathForResource:name ofType:@"png"]];
}

- (void)dealloc{
    _bg = nil;
    _sunOrMoon = nil;
    _img1 = nil;
    _img2 = nil;
    _img3 = nil;
    _img4 = nil;
}

#pragma mark - lazy load
- (UIImageView *)sunOrMoon{
    if (!_sunOrMoon) {
        _sunOrMoon = [[UIImageView alloc] init];
    }
    return _sunOrMoon;
}

- (UIImageView *)img1{
    if (!_img1) {
        _img1 = [[UIImageView alloc] init];
    }
    return _img1;
}

- (UIImageView *)img2{
    if (!_img2) {
        _img2 = [[UIImageView alloc] init];
    }
    return _img2;
}

- (UIImageView *)img3{
    if (!_img3) {
        _img3 = [[UIImageView alloc] init];
    }
    return _img3;
}

- (UIImageView *)img4 {
    if (!_img4) {
        _img4 = [[UIImageView alloc] init];
    }
    return _img4;
}

- (UIImageView *)bg{
    if (!_bg) {
        _bg = [[UIImageView alloc] init];
    }
    return _bg;
}

@end
