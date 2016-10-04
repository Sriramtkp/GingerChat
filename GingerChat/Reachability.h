//
//  Reachability.h
//  GingerChat
//
//  Created by Sriram Rajendran on 12/09/16.
//  Copyright © 2016 Sriram Rajendran. All rights reserved.
//

#ifndef Reachability_h
#define Reachability_h



extension Reachability {
  
  /**
   Determines the current radio access technology and returns one of the mobile data connection types.
   
   - returns: The mobile data connection type currently in use.
   */
  func mobileDataConnectionType() -> MobileDataConnectionType {
    switch CTTelephonyNetworkInfo().currentRadioAccessTechnology {
    case CTRadioAccessTechnologyGPRS:
      return .GPRS
    case CTRadioAccessTechnologyEdge:
      return .Edge
    case CTRadioAccessTechnologyWCDMA, CTRadioAccessTechnologyHSDPA, CTRadioAccessTechnologyHSUPA, CTRadioAccessTechnologyCDMA1x, CTRadioAccessTechnologyCDMAEVDORev0, CTRadioAccessTechnologyCDMAEVDORevA, CTRadioAccessTechnologyCDMAEVDORevB, CTRadioAccessTechnologyeHRPD:
      return .ThreeGee
    case CTRadioAccessTechnologyLTE:
      return .LTE
    default:
      return .Unknown
    }
  }
}

#endif /* Reachability_h */



