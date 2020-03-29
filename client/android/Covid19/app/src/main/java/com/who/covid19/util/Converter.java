package com.who.covid19.util;


import android.util.Log;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class Converter {

    //saeedmpt
    public static String convertMapToString(Map<String, String> data) {
        //convert Map  to String
        return new GsonBuilder().setPrettyPrinting().create().toJson(data);
    }
    public static <T> List<T> convertStringToList(String strListObj) {
        //convert string json to object List
        return new Gson().fromJson(strListObj, new TypeToken<List<Object>>() {
        }.getType());
    }
    public static <T> T convertStringToObj(String strObj, Class<T> classOfT) {
        //convert string json to object
        return new Gson().fromJson(strObj, (Type) classOfT);
    }

    public static <T> T convertStringToArrayObj(String strObj, Class<T> classOfT) {
        //convert string json to object
        Log.e("JSON", strObj);
        return new Gson().fromJson(strObj, (Type) classOfT);
    }

    public static JsonObject convertStringToJsonObj(String strObj) {
        //convert string json to object
        return new Gson().fromJson(strObj, JsonObject.class);
    }

    public static <T> String convertListObjToString(List<T> listObj) {
        //convert object list to string json for
        return new Gson().toJson(listObj, new TypeToken<List<T>>() {
        }.getType());
    }

    public static <T> String convertArrayListObjToString(ArrayList<T> listObj) {
        //convert object list to string json for
        return new Gson().toJson(listObj, new TypeToken<ArrayList<T>>() {
        }.getType());
    }

    public static String convertObjToString(Object clsObj) {
        //convert object  to string json
        return new Gson().toJson(clsObj, new TypeToken<Object>() {
        }.getType());
    }

}
