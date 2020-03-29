package com.who.covid19.apiservice;



import com.who.covid19.intro.model.Content;

import retrofit2.Call;
import retrofit2.http.GET;


public interface ApiService {

    @GET("content.json")
    Call<Content> getContent();

}
