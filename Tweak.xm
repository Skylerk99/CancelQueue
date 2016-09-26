@interface Cydia : NSObject
-(void) cancelAndClear:(bool)arg1;
@end

static BOOL clear = NO;

%hook Cydia
-(void) cancelAndClear:(bool)arg1
{
	if(clear)
	{
		if(arg1 == YES)
		{
			%orig(YES);
			clear = NO;
		}
		else
		{
			%orig;
			clear = NO;
		}
	}
	else
	{
		%orig(NO);
	}
}

%end

%hook InstalledController
-(void) queueButtonClicked
{
	%orig;
	clear = YES;
}
%end