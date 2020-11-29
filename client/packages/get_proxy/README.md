# get_proxy

A flutter plugin to get the proxy details on a mobile device.

## Getting Started

This project can be used to get the proxy details on a mobile device.

## Usage

```import 'package:get_proxy/get_proxy.dart';

var client = new HttpClient();
String proxy = await GetProxy.getProxy;
if(proxy!="")
{
    client.findProxy = (uri) { return proxy; };
}
```
