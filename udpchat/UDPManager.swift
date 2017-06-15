import UIKit
import CocoaAsyncSocket

class UDPManager: NSObject,  GCDAsyncUdpSocketDelegate {
    
    //ssdp stuff
    var ssdpAddres          = "239.255.255.250"
    //var ssdpAddres          = "255.255.255.255"
    var ssdpPort:UInt16     = 1901
    var ssdpSocket: GCDAsyncUdpSocket!
    var error : NSError?
    var delegate: UDPManagerDelegate?
    
    
    override init() {
       super.init()
        //send M-Search
        self.ssdpSocket = GCDAsyncUdpSocket(delegate: self, delegateQueue: DispatchQueue.main)
        try! ssdpSocket.enableBroadcast(true)
        
        
        //bind for responses
      try!  ssdpSocket.bind(toPort: ssdpPort)
      try!  ssdpSocket.joinMulticastGroup(ssdpAddres)
      try!  ssdpSocket.beginReceiving()
    
     
    }
    
    func sendMessage(message: String) {
        ssdpSocket.send(message.data(using: String.Encoding.utf8)!, toHost: ssdpAddres, port: ssdpPort, withTimeout: 1, tag: 0)
    }
    
    func udpSocket(_ sock: GCDAsyncUdpSocket, didConnectToAddress address: Data) {
        
        print("didConnect")
        print(address)
    }
    
     func udpSocket(_ sock: GCDAsyncUdpSocket, didReceive data: Data, fromAddress address: Data, withFilterContext filterContext: Any?) {
        print("didReceive")
        let gotData: NSString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)!
        delegate?.receiveMessage(message: gotData as! String)
        print(gotData as! String)
        
    }
 
    
}
