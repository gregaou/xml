<xsl:stylesheet
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   version="1.0">

   <xsl:output method="xml" indent="yes" />

   <xsl:template match="/">
      <unites>
         <xsl:for-each select="//objet[@type = 'enseignement']">
            <unite id="{@id}">
               <nom><xsl:value-of select="info[@nom='nom']/@value"/></nom>
               <credits><xsl:value-of select="info[@nom='nb_credits']/@value"/></credits>
               <resume><xsl:copy-of select="info[@nom='contenu']/*"/></resume>
               <xsl:for-each select="info[@nom='responsables']">
               <!-- TODO -->
               </xsl:for-each>
            </unite>
         </xsl:for-each>
      </unites>
   </xsl:template>

</xsl:stylesheet>
