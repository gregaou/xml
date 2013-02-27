import org.w3c.dom.*;
import javax.xml.parsers.DocumentBuilderFactory;

public class ue {
  public static void main(String [] args) throws Exception {
    Document doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(args[0]);
    NodeList nodes = doc.getDocumentElement().getElementsByTagName("unite");
    for(int i = 0; i < nodes.getLength(); ++i){
      System.out.println(((Element)nodes.item(i)).getElementsByTagName("nom").item(0).getChildNodes().item(0).getNodeValue());
    }
  }
}
