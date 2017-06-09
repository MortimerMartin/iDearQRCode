//
//  LocalArchiverManager.h
//  iDearQRCode
//
//  Created by Mortimer on 17/6/9.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalArchiverManager : NSObject
/**单例模式，获取请求管理类
*param        param:   无
*returns      return:     无
*/
+ (LocalArchiverManager *)shareManagement;

/**清除本地的序列化的文件
 *param        param:   无
 *returns      return:     无
 */
- (void)clearArchiverData;

/**保存缓存数据
 *param        obj:   数据源
 *param        key:     接口的名称
 *returns      无
 */
- (void)saveDataArchiver:(id)obj andAPIKey:(NSString *)key;

/**获取缓存数据
 *param        obj:   api的key
 *returns      id:     返回的数据源
 */
- (id)archiverQueryAPIKey:(NSString *)key;

@end
