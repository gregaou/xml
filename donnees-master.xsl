<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

   <xsl:output method="xml" indent="yes"/>

   <xsl:template match="/">

      <xsl:text disable-output-escaping="yes">&#xa;&lt;!DOCTYPE master SYSTEM "master.dtd">&#xa;</xsl:text>

      <master>
         <xsl:call-template name="master"/>
      </master>
   </xsl:template>

   <xsl:template name="master">
      <xsl:call-template name="intervenants"/>
      <xsl:call-template name="unites"/>
      <xsl:call-template name="semestre-option-groupe">
         <xsl:with-param name="type" select="'semestre'"/>
      </xsl:call-template>
      <xsl:call-template name="semestre-option-groupe">
         <xsl:with-param name="type" select="'option'"/>
      </xsl:call-template>
      <xsl:call-template name="semestre-option-groupe">
         <xsl:with-param name="type" select="'groupe'"/>
      </xsl:call-template>
      <xsl:call-template name="specialites"/>
   </xsl:template>

   <xsl:template name="intervenants">
      <intervenants>
         <xsl:for-each select="//objet[@type = 'personne']">
            <intervenant id="{@id}">
               <nom>
                  <xsl:value-of select="info[@nom='nom']/@value"/>
               </nom>
               <prenom>
                  <xsl:value-of select="info[@nom='prenom']/@value"/>
               </prenom>
               <email>
                  <xsl:value-of select="info[@nom='mail']/@value"/>
               </email>
               <siteweb></siteweb>
            </intervenant>
         </xsl:for-each>
      </intervenants>
   </xsl:template>

   <xsl:template name="unites">
      <unites>
         <xsl:for-each select="//objet[@type = 'enseignement']">
            <unite id="{@id}">
               <nom>
                  <xsl:value-of select="info[@nom='nom']/@value"/>
               </nom>
               <credits>
                  <xsl:value-of select="info[@nom='nb_credits']/@value"/>
               </credits>
               <resume>
                  <p>
                     <xsl:copy-of select="string(info[@nom='contenu']/*)"/>
                  </p>
								</resume>
								<lieux />
               <xsl:for-each select="info[@nom = 'responsables']">
                  <ref-intervenant ref="{@value}"/>
               </xsl:for-each>
            </unite>
         </xsl:for-each>
      </unites>
   </xsl:template>

   <xsl:template name="semestre-option-groupe">
      <xsl:param name="type"/>
      <xsl:element name="{concat($type,'s')}">
         <xsl:for-each select="//objet[@type = $type]">
            <xsl:element name="{$type}">
               <xsl:attribute name="id">
                  <xsl:value-of select="@id"/>
               </xsl:attribute>
               <nom>
                  <xsl:value-of select="info[@nom = 'nom']/@value"/>
               </nom>
               <credits>
                  <xsl:value-of select="info[@nom = 'nb_credits']/@value"/>
               </credits>
               <numero>
                  <xsl:value-of select="info[@nom = 'numero']/@value"/>
               </numero>
               <structure>
                  <xsl:for-each select="info[@nom = 'structure']">
                     <ref-structure ref="{@value}"/>
                  </xsl:for-each>
               </structure>
            </xsl:element>
         </xsl:for-each>
      </xsl:element>
   </xsl:template>

   <xsl:template name="specialites">
      <specialites>
         <xsl:for-each select="//objet[@type = 'specialite']">
            <xsl:if test="count(info[@nom='structure-specialite']) > 2">
               <specialite id="{@id}">
                  <responsables>
                     <xsl:for-each select="info[@nom='responsables']">
                        <ref-intervenant ref="{@value}"/>
                     </xsl:for-each>
                  </responsables>
                  <nom>
                     M2 <xsl:value-of select="info[@nom = 'nom-court']/@value"/>
                  </nom>
                  <description></description>
                  <!-- <xsl:value-of select="info[@nom = '']/@value" /></description> -->
                  <xsl:for-each select="info[@nom='structure-specialite']">
                     <xsl:if test="@value != 'PRSIN4T0'">
                        <xsl:call-template name="parcours">
                           <xsl:with-param name="id" select="@value"/>
                        </xsl:call-template>
                     </xsl:if>
                  </xsl:for-each>
               </specialite>
            </xsl:if>
         </xsl:for-each>
         <xsl:for-each select="//objet[@type = 'programme']">
            <xsl:if test="not(info[@nom='nom-parcours'])">
               <specialite id="{concat('S',@id)}">
                  <xsl:call-template name="parcours">
                     <xsl:with-param name="id" select="@id"/>
                  </xsl:call-template>
               </specialite>
            </xsl:if>
         </xsl:for-each>
      </specialites>
   </xsl:template>

   <xsl:template name="parcours">
      <xsl:param name="id"/>
      <xsl:for-each select="//objet[@id = $id]">
         <parcours id="{@id}">
            <responsables>
               <xsl:for-each select="info[@nom='responsables']">
                  <ref-intervenant ref="{@value}"/>
               </xsl:for-each>
            </responsables>
            <nom>
               <xsl:choose>
                  <xsl:when test="info[@nom='nom-parcours']">
                     <xsl:value-of select="info[@nom='nom-parcours']/@value"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="info[@nom='nom']/@value"/>
                  </xsl:otherwise>
               </xsl:choose>
            </nom>
            <description></description>
            <debouches></debouches>
            <lieux></lieux>
            <ref-semestres>
               <xsl:for-each select="info[@nom='structure']">
                  <xsl:call-template name="ref-semestre">
                     <xsl:with-param name="id" select="@value"/>
                  </xsl:call-template>
               </xsl:for-each>
            </ref-semestres>
         </parcours>
      </xsl:for-each>
   </xsl:template>

   <xsl:template name="ref-semestre">
      <xsl:param name="id"/>
      <xsl:for-each select="//objet[@id = $id]">
         <ref-semestre ref="{@id}"/>
      </xsl:for-each>

   </xsl:template>

</xsl:stylesheet>
