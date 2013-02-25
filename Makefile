DTD 		= master.dtd
XML 		= master.xml
SCHEMA 	= 
HTML    = www/index.html
XSL 		= master.xsl

all: dtd xsd web tidy xq java
	

dtd:
	@ xmllint --valid --noout $(DTD) $(XML)

xsd:
	@ xmllint --valid --noout --schema $(SCHEMA) $(XML)

web:
	@ rm $(HTML)
	@ xsltproc $(XSL) $(XML) > $(HTML)

tidy:
	@ tidy -utf8 -im $(HTML)

xq:
	@ echo "TODO"

java:
	@ echo "TODO"

