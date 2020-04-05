#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property(nonatomic, strong) UITextField *textFieldRed;
@property(nonatomic, strong) UITextField *textFieldGreen;
@property(nonatomic, strong) UITextField *textFieldBlue;
@property(nonatomic, strong) UIView *resultView;
@property(nonatomic, strong) UILabel *resultLabel;

@end

@implementation ViewController

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setAccessibilityIdentifier:@"mainView"];
    
    int y = 60;
    int x = 20;
    
    [self setupResult:@"Color" withLabelId:@"labelResultColor" withViewId:@"viewResultColor" x:x y:y];

    [self setupColor:@"RED" withlabelId:@"labelRed" withTextFieldId:@"textFieldRed" x:x y:y*2];
    [self setupColor:@"GREEN" withlabelId:@"labelGreen" withTextFieldId:@"textFieldGreen" x:x y:3*y];
    [self setupColor:@"BLUE" withlabelId:@"labelBlue" withTextFieldId:@"textFieldBlue" x:x y:4*y];
    
    [self setupProcessButton:@"Process" withId:@"buttonProcess" y:5*y];
    
}

-(void)setupColor: (NSString*)title withlabelId:(NSString*)labelId withTextFieldId:(NSString*)fieldId x:(CGFloat)x y:(CGFloat)y {
    
    int width = (self.view.bounds.size.width - 2*x);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width/3, 30)];
    [label setText:title];
    [label setAccessibilityIdentifier:labelId];
    [self.view addSubview:label];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(label.bounds.size.width + x, y, (width*2)/3, 30)];
    [textField setPlaceholder:@"0..255"];
    [textField setAccessibilityIdentifier:fieldId];
    [textField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:textField];
    textField.delegate = self;
    
    if ([title isEqual:@"RED"]) {
        self.textFieldRed = textField;
    }
    
    if ([title isEqual:@"GREEN"]) {
        self.textFieldGreen = textField;
    }
    
    if ([title isEqual:@"BLUE"]) {
        self.textFieldBlue = textField;
    }
    
}

-(void)setupResult: (NSString*)title withLabelId:(NSString*)labelId withViewId:(NSString*)viewId x:(CGFloat)x y:(CGFloat)y {
    
    int width = (self.view.bounds.size.width - 2*x);
        
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width/3, 30)];
    [label setText:title];
    [label setAccessibilityIdentifier:labelId];
    [self.view addSubview:label];
    self.resultLabel = label;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(label.bounds.size.width + x + 20 , y, (width*2)/3 - 20, 30)];
    view.backgroundColor = UIColor.redColor;
    [view setAccessibilityIdentifier:viewId];
    [self.view addSubview:view];
    self.resultView = view;
    
}

-(void)setupProcessButton: (NSString*)title withId:(NSString*)buttonId y:(CGFloat)y {
    
    int width = self.view.bounds.size.width/4;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - width)/2, y, width, 30)];
    [button setAccessibilityIdentifier:buttonId];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(createColor:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

-(void)createColor: (UIButton*) button {
        
    NSString *textRed = self.textFieldRed.text;
    NSString *textGreen = self.textFieldGreen.text;
    NSString *textBlue = self.textFieldBlue.text;
    
    [self.textFieldRed setText:@""];
    [self.textFieldGreen setText:@""];
    [self.textFieldBlue setText:@""];
    
    [self.textFieldRed resignFirstResponder];
    [self.textFieldBlue resignFirstResponder];
    [self.textFieldGreen resignFirstResponder];
    
    if ([textRed isEqual:@""] || [textGreen isEqual:@""] || [textBlue isEqual:@""]) {
        [self.resultLabel setText:@"Error"];
        return;
    }
    
    int red = [textRed intValue];
    int green = [textGreen intValue];
    int blue = [textBlue intValue];
    
    if (![[NSString stringWithFormat:@"%d", red] isEqual:textRed] ||
        ![[NSString stringWithFormat:@"%d", green] isEqual:textGreen] ||
        ![[NSString stringWithFormat:@"%d", blue] isEqual:textBlue]
        ) {
        
        [self.resultLabel setText:@"Error"];
        return;
    }
    
    if ( red > 255 || green > 255 || blue > 255) {
        [self.resultLabel setText:@"Error"];
        return;
    }
    
    UIColor *color = [[UIColor alloc] initWithRed: [textRed intValue]/255.0 green:[textGreen intValue]/255.0 blue:[textBlue intValue]/255.0 alpha:1];
    self.resultView.backgroundColor = color;
    [self.resultLabel setText:[@"0x"stringByAppendingString:[NSString stringWithFormat:@"%02X%02X%02X", [textRed intValue], [textGreen intValue], [textBlue intValue]]]];
    
}

-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    [self.resultLabel setText:@"Color"];
    return YES;
}

@end
