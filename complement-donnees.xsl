<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
    <xsl:output method="xml" omit-xml-declaration="no" indent="yes" doctype-public="master" doctype-system="master.dtd" />
    
    <xsl:template match="*|/|text()">
        <xsl:element name="{name(.)}">         
            <xsl:copy-of select="./@*"/>
            <xsl:if test="document('complement-donnees.xml')/complements/complement[@ref = current()/../@id and @node = name(current())] and not(current() != '')">
                <xsl:value-of select="document('complement-donnees.xml')/complements/complement[@ref = current()/../@id and @node = name(current())]"/> 
            </xsl:if>
            <xsl:apply-templates/>           
        </xsl:element>
        
    </xsl:template>
    
   <xsl:template match="text()">
        <xsl:choose>
            <xsl:when test="document('complement-donnees.xml')/complements/complement[@ref = current()/../@id and @node = name(current())]">
                <xsl:value-of select="document('complement-donnees.xml')/complements/complement[@ref = current()/../@id and @node = name(current())]"/> 
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>
