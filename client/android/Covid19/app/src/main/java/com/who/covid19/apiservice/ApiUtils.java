package com.who.covid19.apiservice;

/**
 * Created by irvingleyva on 27/05/2018.
 */

public class ApiUtils {

    private ApiUtils() { }

    public static ApiService getAPIServiceUrl() {
        return RetrofitClient.getClient().create(ApiService.class);
    }
}

