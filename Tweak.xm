@class Database, NSString;

@interface Package
{
	unsigned int era_:25;
	unsigned int role_:3;
	unsigned int essential_:1;
	unsigned int obsolete_:1;
	unsigned int ignored_:1;
	unsigned int pooled_:1;
	unsigned int rank_;
	Database *database_;
	long upgraded_;
	const char *section_;
	NSString *section$_;

}

+ (id)packageWithIterator:(struct PkgIterator)arg1 withZone:(struct _NSZone *)arg2 inPool:(struct CYPool *)arg3 database:(id)arg4;
+ (BOOL)isKeyExcludedFromWebScript:(const char *)arg1;
+ (id)_attributeKeys;
+ (BOOL)isSelectorExcludedFromWebScript:(SEL)arg1;
+ (id)webScriptNameForSelector:(SEL)arg1;
- (void)remove;
- (void)install;
- (void)clear;
- (unsigned int)compareBySection:(id)arg1;
- (void)setIndex:(unsigned long)arg1;
- (_Bool)isCommercial;
- (id)purposes;
- (id)primaryPurpose;
- (BOOL)hasTag:(id)arg1;
- (id)tags;
- (BOOL)matches:(id)arg1;
- (unsigned int)rank;
- (unsigned int)recent;
- (long)upgraded;
- (id)source;
- (id)applications;
- (id)warnings;
- (id)selection;
- (id)state;
- (id)files;
- (id)support;
- (id)author;
- (id)depiction;
- (id)homepage;
- (id)icon;
- (id)name;
- (id)id;
- (id)mode;
- (BOOL)hasMode;
- (BOOL)halfInstalled;
- (BOOL)halfConfigured;
- (BOOL)half;
- (BOOL)visible;
- (BOOL)unfiltered;
- (BOOL)broken;
- (BOOL)essential;
- (BOOL)upgradableAndEssential:(BOOL)arg1;
- (BOOL)uninstalled;
- (id)installed;
- (id)latest;
- (BOOL)ignored;
- (_Bool)setSubscribed:(_Bool)arg1;
- (_Bool)subscribed;
- (long)seen;
- (struct PackageValue *)metadata;
- (unsigned short)index;
- (id)shortDescription;
- (id)longDescription;
- (unsigned long)size;
- (id)md5sum;
- (id)maintainer;
- (id)uri;
- (id)shortSection;
- (id)longSection;
- (id)simpleSection;
- (id)section;
- (id)downgrades;
- (id)initWithVersion:(struct VerIterator)arg1 withZone:(struct _NSZone *)arg2 inPool:(struct CYPool *)arg3 database:(id)arg4;
- (void)parse;
- (id)getRecord;
- (id)getField:(id)arg1;
- (id)architecture;
- (id)relations;
- (id)attributeKeys;
- (void)dealloc;
- (id)description;

@end


@interface Cydia
- (void)removePackage:(Package *)arg1;
- (void)installPackage:(Package *)arg1;
- (void)installPackages:(Package *)arg1;
- (void)clearPackage:(Package *)arg1;
@end

static BOOL clear = NO;
Package *pack;
%hook Cydia

- (void)installPackage:(id)arg1
{
	%orig;
	pack = arg1;

}
- (void)installPackages:(id)arg1
{
	%orig;
	pack = arg1;

}

- (void)removePackage:(id)arg1
{
	%orig;
	pack = arg1;
}

- (void)clearPackage:(id)arg1
{
	%orig;
	pack = arg1;
}


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
		if(arg1 == YES)
		{
			%orig(NO);
			if(pack != nil)
			{
				[self clearPackage:pack];
			}
		}
		else
		{
			%orig;
			clear = NO;
		}
	}
	pack = nil;
}


%end

%hook InstalledController
-(void) queueButtonClicked
{
	%orig;
	clear = YES;
}
%end

