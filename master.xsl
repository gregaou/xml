<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes" encoding="utf-8"/>
  <xsl:strip-space elements="*"/>

  <xsl:variable name="title">Master - Département Informatique de Luminy"</xsl:variable>
  <xsl:template match="/">
    <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html></xsl:text>
    <html>
      <head>
        <title>
          <xsl:value-of select="$title"/>
        </title>
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="css/master.css" rel="stylesheet" type="text/css"/>
      </head>
      <body>
        <div class="row-fluid">
          <div class="page-header">
            <img src="img/banniere2.png" alt="Logo DIL" title="$title"/>
          </div>
        </div>
        <div class="container">
          <div class="row-fluid">
            <div class="span4">
              <xsl:call-template name="menu"/>
            </div>
            <div class="span8">
              <xsl:call-template name="content"/>
            </div>
          </div>
        </div>
        <script src="http://code.jquery.com/jquery-latest.js"/>
        <script src="js/bootstrap.min.js"/>
        <script src="js/master.js"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="menu">
    <ul class="nav nav-tabs nav-stacked">
      <xsl:for-each select="//specialite">
        <li>
          <xsl:choose>
            <xsl:when test="./nom">
              <a href="#{@id}" class="menunav icon-chevron-right">
                <xsl:value-of select="./nom"/>
              </a>
              <ul class="nav nav-tabs nav-pills sousmenu">
                <xsl:for-each select="./parcours">
                  <li>
                    <a href="#{@id}" class="menunav icon-chevron-right">
                      <xsl:value-of select="./nom"/>
                    </a>
                  </li>
                </xsl:for-each>
              </ul>
            </xsl:when>
            <xsl:otherwise>
              <a href="#{./parcours/@id}" class="menunav icon-chevron-right">
                <xsl:value-of select="./parcours/nom"/>
              </a>
            </xsl:otherwise>
          </xsl:choose>
        </li>
      </xsl:for-each>
      <li>
        <a href="#intervenant" class="menunav">Intervenants</a>
      </li>
    </ul>
  </xsl:template>

  <xsl:template name="content">
    <xsl:apply-templates select="//specialite"/>
  </xsl:template>

  <xsl:template match="intervenants">
    <div id="intervenants" class="span12">
      <xsl:for-each select="./intervenant">
        <xsl:sort select="nom"/>
        <ul>
          <li>
            <a href="mailto:{email}">
              <xsl:value-of select="nom"/>
            </a>
            <xsl:if test="not(siteweb='')">
              <a href="{siteweb}" class="icon-globe"/>
            </xsl:if>
          </li>
        </ul>
      </xsl:for-each>
    </div>
  </xsl:template>

  <xsl:template match="specialite">
    <div id="{@id}" class="specialite">
      <h1>
        <xsl:value-of select="nom"/>
      </h1>
    </div>
    <xsl:apply-templates select="parcours"/>
  </xsl:template>

  <xsl:template match="parcours">
    <div id="{@id}" class="parcours">
      <h1>
        <xsl:value-of select="nom"/>
      </h1>
      <h2>Description</h2>
      <p>
        <xsl:value-of select="description"/>
      </p>
      <xsl:apply-templates select="responsables"/>
      <xsl:apply-templates select="debouches"/>
      <xsl:apply-templates select="lieux"/>
      <xsl:apply-templates select="semestre"/>
    </div>
  </xsl:template>

  <xsl:template match="debouches">
    <h2>Débouchés</h2>
    <ul>
      <xsl:for-each select="item">
        <li>
          <xsl:value-of select="."/>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>

  <xsl:template match="lieux">
    <h2>Lieux</h2>
    <ul>
      <xsl:for-each select="item">
        <li>
          <xsl:value-of select="."/>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>

  <xsl:template match="responsables">
    <h2>Responsables</h2>
    <ul>
      <xsl:for-each select="ref-intervenant">
        <li>
          <xsl:value-of select="/master/intervenants/intervenant[@id = current()/@ref]/nom"/>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>

  <xsl:template match="semestre">
    <h3>Semestre <xsl:value-of select="@num"/></h3>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="bloc">
    <h3>Options <xsl:value-of select="@role"/></h3>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="ref-unite">
    <xsl:apply-templates select="/master/unites/unite[@id = current()/@ref]"/>
  </xsl:template>

  <xsl:template match="unite">
    <h4><xsl:value-of select="@id"/> : <xsl:value-of select="nom"/></h4>
    <p>Crédits : <xsl:value-of select="credits"/></p>
    <h5>Résumé</h5>
    <xsl:apply-templates select="resume"/>
    <xsl:apply-templates select="plan"/>
  </xsl:template>

  <xsl:template match="resume">
    <p>
      <xsl:value-of select="."/>
    </p>
  </xsl:template>

  <xsl:template match="plan">
    <h5>Plan du cours</h5>
    <ul>
      <xsl:for-each select="item">
        <li>
          <xsl:value-of select="."/>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>



</xsl:stylesheet>
