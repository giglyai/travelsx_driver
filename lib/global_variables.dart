//screen height and width of user device will be stored here

import 'package:flutter/material.dart';
import 'package:travelx_driver/login/entity/country_list/country_list.dart';

///selected page for nottom navigation bar

PageController? pageController;

double ScreenHeight = 0;
double ScreenWidth = 0;

///Phone pay Cred
String merchantId = "GIGLYDRIVERONLINE";
String saltKey = "cdc36847-4b78-48f8-a54e-c5c46eef22ad";
String environment = "PRODUCTION";
String appId = "";
String saltIndex = "1";
String apiEndPoint = "/pg/v1/pay";
String calkBackUrl =
    "https://webhook.site/b4c8335d-b9b7-4b16-b78f-bf03f47ec537";

///In APP update Credentials
String iosAppID = '1637298904';
bool userIsNew = true;
bool isUserVisitedUpdate = false;
bool isUpdateCrucial = true;
String? updateAppVersion;
bool isUpdatePossible = false;

bool confirmButtonIsEnable = false;
bool joiningDone = false;

bool? logoutVersion;
CountryCodeList? countryCodeList;

///these variables are stored for portfolio based implementation coming from API
///user convert fee if the user plan is basic
//TODO change this to production APi

//String parentApi = 'https://prod.gigly.ai/';
//String parentApi = 'http://10.0.2.2:9001/';
//String parentApi = 'http://192.168.1.6:9001/'; // iOS local app
String parentApi = 'http://192.168.29.243:9001/';

Map<String, String> header = {
  'authority': 'https://prod.gigly.ai',
  'sec-ch-ua':
      '"Google Chrome";v="93", " Not;A Brand";v="99", "Chromium";v="93"',
  'content-type': 'application/json',
  'user-agent':
      'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
  'sec-ch-ua-platform': '"Linux"',
  'origin': 'https://prod.gigly.ai/',
  'sec-fetch-site': 'same-site',
  'sec-fetch-mode': 'cors',
  'sec-fetch-dest': 'empty',
  'referer': 'https://prod.gigly.ai/',
  'accept-language': 'en-IN,en-GB;q=0.9,en-US;q=0.8,en;q=0.7,hi;q=0.6',
};
