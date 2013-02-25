import org.w3c.dom.*;
import java.io.*;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

public class ue {
  public static void main(String [] args) throws Exception {
    Document doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(args[0]);
    Element ue = (Element)doc.getDocumentElement().getElementsByTagName("unite").item(0);
    System.out.println(ue);
    Node nom = ue.getElementsByTagName("nom").item(0);
    System.out.println(ue.getAttribute("id"));
    System.out.println(nom.getNodeValue());
  }
}
