MAIN      = master
DTD				= $(MAIN).dtd
XML				= $(MAIN).xml
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
	xmllint --valid --noout $(DTD) $(XML)

xsd:
	xmllint --valid --noout --schema $(SCHEMA) $(XML)

web: clean_web
	cd $(WWW) && xsltproc ../$(XSL) ../$(XML)

tidy:
	tidy -utf8 -im $(WWW)*.html

xq:
	java -cp java_tools/saxon9he.jar net.sf.saxon.Query $(XQ) > $(XQO)

java:
	cd java_tools/ && javac $(SRC_JAVA) && java $(JAVA) ../$(XML)

#$(XML): donnees-master.xsl donnees-master.xml
	#xsltproc $^ > $(XML)
	#java -cp java_tools/saxon9he.jar net.sf.saxon.Transform master.xml complement-donnees.xsl

clean_web:
	([ -f $(WWW)$(HTML) ] && rm $(WWW)$(WEB)) || echo "Rien à supprimer"
