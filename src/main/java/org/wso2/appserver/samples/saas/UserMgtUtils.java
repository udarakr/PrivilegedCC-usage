/*
 *  Copyright (c) 2005-2009, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 *  WSO2 Inc. licenses this file to you under the Apache License,
 *  Version 2.0 (the "License"); you may not use this file except
 *  in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing,
 *  software distributed under the License is distributed on an
 *  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 *  KIND, either express or implied.  See the License for the
 *  specific language governing permissions and limitations
 *  under the License.
 *
 */
package org.wso2.appserver.samples.saas;

import org.wso2.carbon.context.PrivilegedCarbonContext;
import org.wso2.carbon.user.api.UserRealmService;
import org.wso2.carbon.user.api.UserStoreException;

public class UserMgtUtils {

    public static String[] getTenantUserNames(int tenantID) throws UserStoreException {
        UserRealmService realmService = (UserRealmService) PrivilegedCarbonContext
                .getCurrentContext().getOSGiService(UserRealmService.class);
        String[] userNames = realmService.getTenantUserRealm(tenantID)
                .getUserStoreManager().listUsers("*", 100);
        return userNames;
    }

    public static boolean addTenantUser(String username, String password, int tenantID) throws UserStoreException {
        if (username != null && username.trim().length() > 0) {
            UserRealmService realmService = (UserRealmService)
                    PrivilegedCarbonContext.getCurrentContext().getOSGiService(UserRealmService.class);
            if (!realmService.getTenantUserRealm(tenantID).getUserStoreManager().isExistingUser(username)) {
                realmService.getTenantUserRealm(tenantID).getUserStoreManager().addUser(username, password, null, null, null);
                return true;
            }
        }
        return false;
    }

    public static boolean checkExistingTenantUser(String username, int tenantID) throws UserStoreException {
        UserRealmService realmService = (UserRealmService)
                PrivilegedCarbonContext.getCurrentContext().getOSGiService(UserRealmService.class);
        return realmService.getTenantUserRealm(tenantID).getUserStoreManager().isExistingUser(username);
    }
}
