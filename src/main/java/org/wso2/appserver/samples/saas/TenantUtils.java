package org.wso2.appserver.samples.saas;

import org.wso2.carbon.context.PrivilegedCarbonContext;
import org.wso2.carbon.user.api.TenantManager;
import org.wso2.carbon.user.api.UserRealmService;
import org.wso2.carbon.user.api.UserStoreException;

public class TenantUtils {

    public static int getTenantId(String tenantDomain) throws UserStoreException {
        UserRealmService realmService = (UserRealmService)
                PrivilegedCarbonContext.getCurrentContext().getOSGiService(UserRealmService.class);
        TenantManager tenantManager = realmService.getTenantManager();
        return tenantManager.getTenantId(tenantDomain);
    }
}
