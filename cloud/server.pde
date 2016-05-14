import processing.net.*;
import java.net.SocketException;

int port = 80;

Server myServer;

int getMessege() {
  String s = new String();
 
  Client thisClient = myServer.available();
  
  if (thisClient != null) {
    if (thisClient.available() > 0) {
      //fprintln("mesage from: " + thisClient.ip());
      println("Millis : " + millis());
      s = thisClient.readString();
      //println(s);
      s = s.substring(6, 7);
      thisClient.write("Mood cloud got " + s);
      myServer.disconnect(thisClient);
    }
  }
 

  return int(s);
  
}
