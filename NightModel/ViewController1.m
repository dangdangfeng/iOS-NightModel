
#import "ViewController1.h"
#import "DTNightVersion.h"
#import "ViewController2.h"

@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.dt_backgroundColorPicker = DTColorPickerWithColors([UIColor greenColor],[UIColor blueColor]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.navigationController pushViewController:[ViewController2 new] animated:YES];
}

- (void)dealloc{
    NSLog(@"vc1");
}

@end
