<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
  <xsl:output method="html"
              indent="yes"
              encoding="utf-8"/>
  <xsl:strip-space elements="*"/>
  <xsl:template match="master">
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
    <html>
      <head>
        <title>Master</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" />
        <link href="master.css" rel="stylesheet" />
      </head>
      <body>
      <xsl:apply-templates />
      </body>
    </html>
  </xsl:template>

  <xsl:template match="intervenant">
    <div class="intervenant">
       <h2>Intervenant <xsl:value-of select="nom" /></h2>
       <p><xsl:value-of select="email" /></p>
       <p><xsl:value-of select="siteweb" /></p>
    </div>
  </xsl:template>

  <xsl:template match="specialite">
    <div class="specialite">
      <h1><xsl:value-of select="nom" /></h1>
      <xsl:apply-templates select="parcours" />
    </div>
  </xsl:template>

  <xsl:template match="parcours">
    <div class="parcours">
      <h1><xsl:value-of select="nom" /></h1>
      <h2>Description</h2>
      <p><xsl:value-of select="description" /></p>
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="debouches">
    <h2>Débouchés</h2>
    <ul>
    <xsl:for-each select="item">
       <li><xsl:value-of select="." /></li>
    </xsl:for-each>
    </ul>
  </xsl:template>

  <xsl:template match="lieux">
    <h2>Lieux</h2>
    <ul>
    <xsl:for-each select="item">
       <li><xsl:value-of select="." /></li>
    </xsl:for-each>
    </ul>
  </xsl:template>

  <xsl:template match="responsables">
    <h2>Responsables</h2>
    <ul>
    <xsl:for-each select="item">
       <li><xsl:value-of select="." /></li>
    </xsl:for-each>
    </ul>
  </xsl:template>

  <xsl:template match="semestre">
    <h3>Semestre <xsl:value-of select="@num" /></h3>
    <xsl:apply-templates /> 
  </xsl:template>

  <xsl:template match="bloc">
    <h3>Options <xsl:value-of select="@role" /></h3>
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="unite">
    <h4><xsl:value-of select="@id" /> : <xsl:value-of select="nom" /></h4>
    <p>Crédits : <xsl:value-of select="credits" /></p>
    <h5>Résumé</h5>
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="resume">
    <p><xsl:value-of select="." /></p>
  </xsl:template>

  <xsl:template match="plan">
    <h5>Plan du cours</h5>
    <ul>
    <xsl:for-each select="item">
       <li><xsl:value-of select="." /></li>
    </xsl:for-each>
    </ul>
  </xsl:template>

</xsl:stylesheet>
