DTD				= new-data.dtd
XML				= new-data.xml
SCHEMA		= new_master.xsd
WWW				= www/
HTML			= index.html
XSL				= new-data.xsl
JAVA			= ue
SRC_JAVA 	= $(patsubst %, %.java, $(JAVA))
WEB				= *.html
XQ				= xquery/xq.txt
XQO				= xq.html

all: dtd xsd web tidy xq java
	

dtd:
	xmllint --valid --noout $(DTD) $(XML)

xsd:
	xmllint --valid --noout --schema $(SCHEMA) $(XML)

web: clean_web
	cd $(WWW) && xsltproc ../$(XSL) ../$(XML) > $(HTML)

tidy:
	tidy -utf8 -im $(WWW)*.html

xq:
	java -cp _old/saxon9he.jar net.sf.saxon.Query $(XQ) > $(XQO)

java:
	javac $(SRC_JAVA)
	java $(JAVA) $(XML)

clean_web:
	([ -f $(WWW)$(HTML) ] && rm $(WWW)$(WEB)) || echo "Rien à supprimer"
