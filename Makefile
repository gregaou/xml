DTD			= new-data.dtd
XML			= new-data.xml
SCHEMA	= 
WWW 		= www/
HTML 		= index.html
XSL			= new-data.xsl
JAVA 		= ue.java
WEB 		= *.html
XQ  		= xq.txt
XQO     = xq.html

all: dtd xsd web tidy xq java
	

dtd:
	xmllint --valid --noout $(DTD) $(XML)

xsd:
	xmllint --valid --noout --schema $(SCHEMA) $(XML)

web: clean_web
	cd $(WWW) && xsltproc ../$(XSL) ../$(XML) > $(HTML)

tidy:
	tidy -utf8 -im $(HTML)

xq:
	java -cp saxon9he.jar net.sf.saxon.Query $(XQ) > $(XQO)

java:
	javac $(JAVA)

clean_web:
	([ -f $(WWW)$(HTML) ] && rm $(WWW)$(WEB)) || echo "Rien à supprimer"
