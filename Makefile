MAIN      = master
DTD				= $(MAIN).dtd
XML				= $(MAIN).xml
XMLT			= $(XML).tmp
SCHEMA		= $(MAIN).xsd
XSL				= $(MAIN).xsl
WWW				= www/
HTML			= index.html
JAVA			= ue
SRC_JAVA 	= $(patsubst %, %.java, $(JAVA))
WEB				= *.html
XQ				= xq.txt
XQO				= xq.html

all: $(XML) dtd xsd web tidy xq java
	
dtd:
	xmllint --noout --valid $(XML)
	xmllint --noout --dtdvalid  $(DTD) $(XML)

xsd:
	xmllint --noout --valid --schema $(SCHEMA) $(XML)

web: clean_web $(XML)
	cd $(WWW) && xsltproc ../$(XSL) ../$(XML)

tidy:
	tidy -utf8 -e -q -im -asxhtml -indent $(WWW)*.html

xq:
	java -cp java_tools/saxon9he.jar net.sf.saxon.Query $(XQ) > $(XQO)

java:
	cd java_tools/ && javac $(SRC_JAVA) && java $(JAVA) ../$(XML)

$(XML): donnees-master.xsl donnees-master.xml
	xsltproc $^ > $(XMLT)
	saxon-xslt -w0 $(XMLT) complement-donnees.xsl > $(XML)
	rm $(XMLT)

clean_xml:
	rm $(XMLT) $(XML)

clean_web:
	([ -f $(WWW)$(HTML) ] && rm $(WWW)$(WEB)) || echo "Rien à supprimer"
	
clean : clean_web clean_xml
