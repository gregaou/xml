<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
  <xsl:output method="html"
              indent="yes"
              encoding="utf-8"/>

  <xsl:template match="master">
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html>
</xsl:text>
    <html>
      <head>
        <title>Master</title>
      </head>
      <body>
      <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="intervenant">
    <h2>Intervenant <xsl:value-of select="nom"/></h2>
  </xsl:template>

</xsl:stylesheet>
