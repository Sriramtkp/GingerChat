

import Foundation
import SystemConfiguration

class Server {
  //MARK: isConnectedToInternet
  static func isConnectedToInternet() -> Bool {
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
      SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
    }
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
      return false
    }
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    return (isReachable && !needsConnection)
  }
  
  
  //MARK: sendPost

  static func sendPost(url: String) {
    let session = NSURLSession.sharedSession()
    let nsurl = NSURL(string: url)
    let request = NSMutableURLRequest(URL: nsurl!)
    request.HTTPMethod = "POST"
    request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
    let task = session.dataTaskWithRequest(request)
    task.resume()
  }
  //MARK: sendPost
  static func sendPost(url: String, completionHandler: (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void) {
    let session = NSURLSession.sharedSession()
    let nsurl = NSURL(string: url)
    let request = NSMutableURLRequest(URL: nsurl!)
    request.HTTPMethod = "POST"
    request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
    let task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
    task.resume()
  }
  
  //MARK: sendPost
  static func sendPost(url: String, params: NSMutableDictionary, completionHandler: (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void) {
    let session = NSURLSession.sharedSession()
    let nsurl = NSURL(string: url)
    let request = NSMutableURLRequest(URL: nsurl!)
    request.HTTPMethod = "POST"
    request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
    request.HTTPShouldHandleCookies = true
    
    
    let jsonObject = makeJSONObject(params)
    print(params)
    print(jsonObject)
    request.HTTPBody = jsonObject
    let task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
    task.resume()
  }
  //MARK: sendPost
  static func sendPost(url: String, params: [String:AnyObject], completionHandler: (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void) {
    let session = NSURLSession.sharedSession()
    let nsurl = NSURL(string: url)
    let request = NSMutableURLRequest(URL: nsurl!)
    request.HTTPMethod = "POST"
    request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
    request.HTTPShouldHandleCookies = true
    print(params)
    
    let jsonObject = makeJSONObject(params)
    request.HTTPBody = jsonObject
    let task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
    task.resume()
  }
  //MARK: sendPostWithHtml
  static func sendPostWithHtml(url: String, params: [[String:AnyObject]], completionHandler: (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void) {
    let session = NSURLSession.sharedSession()
    let nsurl = NSURL(string: url)
    let request = NSMutableURLRequest(URL: nsurl!)
    request.HTTPMethod = "POST"
    //Cookies
    let req = NSHTTPCookieStorage.sharedHTTPCookieStorage().cookies
    var cookieProperties = [String: AnyObject]()
    var cookieval : String = ""
    for cookie in req!{
      cookieProperties[NSHTTPCookieName] = "JSESSIONID"
      cookieProperties[NSHTTPCookieValue] = cookie.value
      cookieval = cookie.value
      cookieProperties[NSHTTPCookieDomain] = cookie.domain
      cookieProperties[NSHTTPCookiePath] = cookie.path
      cookieProperties[NSHTTPCookieVersion] = NSNumber(integer: cookie.version)
      cookieProperties[NSHTTPCookieExpires] = NSDate().dateByAddingTimeInterval(10)
    }
    let cookieprop = NSHTTPCookie(properties: cookieProperties)
    let cookies : [NSHTTPCookie] = [cookieprop!]
    let cookieHeaders = NSHTTPCookie.requestHeaderFieldsWithCookies(cookies)
    request.allHTTPHeaderFields = cookieHeaders
    print(request.allHTTPHeaderFields)
    request.setValue("JSESSIONID=\(cookieval)", forHTTPHeaderField: "Cookie")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    let jsonObject = makeJSONObject(params)
    print(jsonObject)
    request.HTTPBody = jsonObject
    let task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
    task.resume()
  }
  //MARK: sendPost
  static func sendPost(url: String, params: [String:AnyObject]) {
    let session = NSURLSession.sharedSession()
    let nsurl = NSURL(string: url)
    let request = NSMutableURLRequest(URL: nsurl!)
    request.HTTPMethod = "POST"
    request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
    let jsonObject = makeJSONObject(params)
    request.HTTPBody = jsonObject
    let task = session.dataTaskWithRequest(request)
    task.resume()
  }
  
  
  //MARK: Get Method
    static func sendGet(url: String, completionHandler: (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void) {
    let session = NSURLSession.sharedSession()
    let nsurl = NSURL(string: url)
    let request = NSMutableURLRequest(URL: nsurl!)
    print(request)
    request.HTTPMethod = "GET"
    request.setValue("0", forHTTPHeaderField: "Content-length")
    let task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
    task.resume()
  }
  //MARK: makeJSONObject
  static func makeJSONObject(params: NSMutableDictionary) -> NSData?{
    var jsonObject: NSData? = nil
    do{
      jsonObject = try NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions())
      print(jsonObject)
    } catch{}
    return jsonObject
  }
  
  //MARK: makeJSONObject
  static func makeJSONObject(params: [String:AnyObject]) -> NSData?{
    var jsonObject: NSData? = nil
    do{
      jsonObject = try NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions())
    } catch{}
    return jsonObject
  }
  
  //MARK: makeJSONObject
  static func makeJSONObject(params: [[String:AnyObject]]) -> NSData?{
    var jsonObject: NSData? = nil
    //dispatch_async(dispatch_get_main_queue()){
    do{
      jsonObject = try NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions())
      print(params)
      print(dataToString(jsonObject))
    } catch{}
    //}
    return jsonObject
  }
  
  //MARK: dataToNSDictionary
  static func dataToNSDictionary(data: NSData?) -> NSDictionary?{
    do {
      let responseObject = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
      return responseObject
    } catch {}
    return nil
  }
  //MARK: dataToNSMutableDictionary
  static func dataToNSMutableDictionary(data: NSData?) -> NSMutableDictionary?{
    do {
      let responseObject = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSMutableDictionary
      return responseObject
    } catch {}
    return nil
  }
  //MARK: dataToNSArray
  static func dataToNSArray(data: NSData?) -> NSArray?{
    do {
      let responseObject = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray
      return responseObject
    } catch {}
    return nil
  }
  //MARK: dataToTrimmedString
  static func dataToTrimmedString(data: NSData?) -> String{
    if data != nil {
      var responseString = NSString(data:data!, encoding:NSUTF8StringEncoding)?.stringByReplacingOccurrencesOfString("\"", withString: " ") ?? ""
      responseString = responseString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
      return responseString
    }
    return ""
  }
  //MARK: dataToString
  static func dataToString(data: NSData?) -> String{
    if data != nil {
      var responseString = NSString(data:data!, encoding:NSUTF8StringEncoding)?.stringByReplacingOccurrencesOfString("\"", withString: "\"") ?? ""
      responseString = responseString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
      return responseString
    }
    return ""
  }
}
