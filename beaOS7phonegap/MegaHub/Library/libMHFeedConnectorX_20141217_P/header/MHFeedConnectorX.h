#import <Foundation/Foundation.h>
#import "MHFeedConnectorXConstant.h"
#import "MHLanguage.h"

#import "MHFeedXObjStockQuote.h"
#import "MHFeedXObjIndexName.h"
#import "MHFeedXObjSector.h"
#import "MHFeedXObjForex.h"
#import "MHFeedXObjMetal.h"
#import "MHFeedXObjQuote.h"

#import "MHFeedXMsgInGetLocalIndexName.h"
#import "MHFeedXMsgInGetSpreadInfo.h"
#import "MHFeedXMsgInGetNewsSource.h"
#import "MHFeedXMsgInGetSectorName.h"
#import "MHFeedXMsgInGetLiteQuote.h"
#import "MHFeedXMsgInGetTime.h"
#import "MHFeedXMsgInNewLogin.h"

@interface MHFeedConnectorX : NSObject {

    BOOL                m_isPrintMsg;
    
	NSOperationQueue	*m_oOperationQueue;
	
	unsigned int		m_uiCurrentMsgID;
	
	MHFeedXMsgInGetSpreadInfo *m_oMHFeedXMsgInGetSpreadInfo;
	MHFeedXMsgInGetNewsSource	*m_oMHFeedXMsgInGetNewsSource;
	MHFeedXMsgInGetSectorName	*m_oMHFeedXMsgInGetSectorName;
	MHFeedXMsgInNewLogin			*m_oMHFeedXMsgInLogin;
	MHFeedXMsgInGetLocalIndexName *m_oMHFeedXMsgInGetLocalIndexName;
    NSMutableDictionary *m_oMarketInfoDict;
	NSString *m_sPermissionString;
    NSString *m_sCachedTimestamp;
    NSDate *m_oLastTimestampUpdate;
    
}
@property(nonatomic, retain)MHFeedXMsgInNewLogin *m_oMHFeedXMsgInLogin;
@property(retain)MHFeedXMsgInGetSpreadInfo	*m_oMHFeedXMsgInGetSpreadInfo;
@property(retain)MHFeedXMsgInGetNewsSource	*m_oMHFeedXMsgInGetNewsSource;
@property(retain)MHFeedXMsgInGetSectorName	*m_oMHFeedXMsgInGetSectorName;
@property(retain)NSString					*m_sPermissionString;

+ (MHFeedConnectorX *)sharedMHFeedConnectorX;
- (void)release;
- (id)autorelease;
- (NSUInteger)retainCount;
- (id)retain;
- (id)copyWithZone:(NSZone *)zone;
+ (id)allocWithZone:(NSZone *)zone;

- (void)setDebugMessage:(BOOL)aBool ;
- (BOOL)getDebugMessage;
- (char)getBuildMode ;

- (void)addGetLiteQuoteObserver:(id)aObserver action:(SEL)aAction;
- (void)removeGetLiteQuoteObserver:(id)aObserver;
- (unsigned int)getLiteQuoteWithAuthen:(NSArray *)aSymbolArray
                                  type:(NSArray *)aTypeArray
                              language:(Language)aLanguage
                            fromObject:(NSObject *)aNSObject
                              freeText:(NSString *)aFreeText
                                action:(NSString *)aAction
                              realtime:(NSString *)aRealTime;

#pragma mark GetSpread
- (float)getSpread:(float)aInput type:(int)aType;

- (NSString *)urlNewsStyle:(NSString *)aStyle
                  language:(Language)aLanguage
                    source:(NSString *)aSource
                     group:(NSString *)aGroup
                     stock:(NSString *)aStock
                    action:(NSString *)aAction
                   version:(NSString *)aVersion
                         v:(NSString *)aV ;

#pragma mark Sector
- (void)addGetSectorName:(id)aObserver action:(SEL)aAction;
- (void)removeGetSectorName:(id)aObserver;
- (unsigned int)getSectorNameLanguage:(Language)aLang freeText:(NSString *)aFreeText;
- (void)onGetSectorName:(NSNotification *)n;
- (MHFeedXObjSector *)getSectorDespWithSectorC:(NSString *)aSectorC;
- (NSArray *)getSectorArray;

#pragma marl generate url
- (NSString *)urlSectorWithStock:(NSString *)aSymbolWithOutLeadingZero
                           style:(NSString *)aStyle
                          action:(NSString *)aAction
                        realtime:(NSString *)aRealTime
                         version:(NSString *)aVersion
                               v:(NSString *)aV ;
- (NSString *)urlSectorWithC:(NSString *)aSector
                       style:(NSString *)aStyle
                      action:(NSString *)aAction
                    realtime:(NSString *)aRealTime
                     version:(NSString *)aVersion
                           v:(NSString *)aV ;

#pragma mark RelateQuote
- (NSString *)urlRelatedQuoteView:(NSString *)aStyle
                         language:(Language)aLanguage
                      refreshRate:(NSString *)aRefreshRate
                        warrantID:(NSString *)aWarrantID
                           action:(NSString *)aAction
                         realtime:(NSString *)aRealTime
                          version:(NSString *)aVersion
                                v:(NSString *)aV ;


- (NSString *)urlRelatedQuoteView:(NSString *)aStyle
                         language:(Language)aLanguage
                      refreshRate:(NSString *)aRefreshRate
                          stockID:(NSString *)aStockID
                           action:(NSString *)aAction
                         realtime:(NSString *)aRealTime
                          version:(NSString *)aVersion
                                v:(NSString *)aV ;

- (NSString *)urlIndexConstituent:(NSString *)aStyle
                         language:(Language)aLanguage
                      refreshRate:(NSString *)aRefreshRate
                            index:(NSString *)aIndex
                           action:(NSString *)aAction
                         realtime:(NSString *)aRealTime
                          version:(NSString *)aVersion
                                v:(NSString *)aV ;

- (NSString *)urlAHShares:(NSString *)aStyle
                 language:(Language)aLanguage
              refreshRate:(NSString *)aRefreshRate
                   action:(NSString *)aAction
                 realtime:(NSString *)aRealTime
                  version:(NSString *)aVersion
                        v:(NSString *)aV ;

- (NSString *)urlTopRank:(NSString *)aStyle
                language:(Language)aLanguage
             refreshRate:(NSString *)aRefreshRate
                  sector:(NSString *)aSector
                category:(NSString *)aCategory
                  action:(NSString *)aAction
                realtime:(NSString *)aRealTime
                 version:(NSString *)aVersion
                       v:(NSString *)aV;

#pragma mark Utility
- (NSString *)getTGT:(NSString *)aAction;

#pragma mark GetWorldIndex
- (unsigned int)getWorldIndexFreeText:(NSString *)aFreeText;
- (void)addGetWorldIndexObserver:(id)aObserver action:(SEL)aAction;
- (void)removeGetWorldIndexObserver:(id)aObserver;

- (unsigned int)getStockNameSearch:(Language)aLang search:(NSString *)aKeyWord page:(int)aPage freeText:(NSString *)aFreeText searchType:(NSString *)searchType;
- (void)addGetStockNameSearchObserver:(id)aObserver action:(SEL)aAction;
- (void)removeGetStockNameSearchObserver:(id)aObserver;

#pragma mark GetLocalIndexName
- (void)addGetLocalIndexNameObserver:(id)aObs action:(SEL)aAction;
- (void)removeGetLocalIndexNameObserver:(id)aObs;
- (unsigned int)getLocalIndexName:(NSString *)aFreeText language:(Language)aLang;
- (MHFeedXMsgInGetLocalIndexName *)getLocalIndexName;
- (MHFeedXObjIndexName *)localIndexFromID:(int)aID;
- (MHFeedXObjIndexName *)localIndexFromSymbol:(NSString *)aSymbol;

- (unsigned int)getTime:(id)aTarget action:(SEL)aSel para:(NSObject *)aPara ;

@end