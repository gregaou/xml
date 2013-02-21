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
            <img src="img/banniere3.png" alt="Logo DIL" title="$title"/>
          </div>
        </div>
        <div class="container">
          <div class="row-fluid">
            <div class="span4">
              <xsl:call-template name="menu"/>
            </div>
            <div class="span8">
              <xsl:call-template name="content"/>
              <xsl:apply-templates select="//intervenants"/>
              <xsl:apply-templates select="//unites"/>
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
              <a href="#{@id}" class="menunav">
                <xsl:value-of select="./nom"/>
              </a>
              <ul class="nav nav-tabs nav-pills sousmenu">
                <xsl:for-each select="./parcours">
                  <li>
                    <a href="#{@id}" class="menunav">
                      <xsl:value-of select="./nom"/>
                    </a>
                  </li>
                </xsl:for-each>
              </ul>
            </xsl:when>
            <xsl:otherwise>
              <a href="#{./parcours/@id}" class="menunav">
                <xsl:value-of select="./parcours/nom"/>
              </a>
            </xsl:otherwise>
          </xsl:choose>
        </li>
      </xsl:for-each>
      <li>
        <a href="#intervenants" class="menunav">Intervenants</a>
      </li>
      <li>
        <a href="#unites" class="menunav">Unités</a>
      </li>
    </ul>
  </xsl:template>

  <xsl:template name="content">
    <xsl:apply-templates select="//specialite"/>
  </xsl:template>

  <xsl:template match="intervenants">
    <div id="intervenants" class="intervenants">
      <h1>Intervenants</h1>
      <table class="table table-striped table-bordered">
        <xsl:for-each select="./intervenant">
          <xsl:sort select="nom"/>
          <tr>
            <td>
              <a href="#{@id}" class="lien">
                <xsl:value-of select="nom"/>
                <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                <xsl:value-of select="prenom"/>
              </a>
            </td>
            <td>
              <xsl:if test="not(email='')">
                <a href="mailto:{email}" class="icon-envelope"/>
              </xsl:if>
            </td>
            <td>
              <xsl:if test="not(siteweb='')">
                <a href="{siteweb}" class="icon-globe"/>
              </xsl:if>
            </td>
          </tr>
        </xsl:for-each>
      </table>
    </div>
    <xsl:for-each select="./intervenant">
      <xsl:call-template name="sintervenant"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="sintervenant">
    <div class="intervenant" id="{@id}">
      <h1>
        <xsl:value-of select="nom"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="prenom"/>
      </h1>
      <h2>Informations</h2>
      <ul>
        <xsl:if test="not(email='')">
          <li>
            <a href="mailto:{email}">Email</a>
          </li>
        </xsl:if>
        <xsl:if test="not(siteweb='')">
          <li>
            <a href="{siteweb}">Site Web</a>
          </li>
        </xsl:if>
      </ul>
      <xsl:if test="/master/unites/unite/ref-intervenant[@ref = current()/@id]">
        <h3>Intervenant des unités d'enseignement :</h3>
      </xsl:if>
      <ul>
        <xsl:for-each select="/master/unites/unite/ref-intervenant[@ref = current()/@id]">
          <li>
            <a href="#{../@id}" class="lien">
              <xsl:value-of select="../nom"/>
            </a>
          </li>
        </xsl:for-each>
      </ul>
      <xsl:if
        test="/master/specialite/responsables/ref-intervenant[@ref = current()/@id] or /master/specialite/parcours/responsables/ref-intervenant[@ref = current()/@id]">
        <h3>Responsables des parcours/specialités :</h3>
      </xsl:if>
      <ul>
        <xsl:for-each select="/master/specialite/responsables/ref-intervenant[@ref = current()/@id]">
          <li>
            <a href="#{../../@id}" class="lien">
              <xsl:value-of select="../../nom"/>
            </a>
          </li>
        </xsl:for-each>
        <xsl:for-each
          select="/master/specialite/parcours/responsables/ref-intervenant[@ref = current()/@id]">
          <li>
            <a href="#{../../@id}" class="lien">
              <xsl:value-of select="../../nom"/>
            </a>
          </li>
        </xsl:for-each>
      </ul>
    </div>
  </xsl:template>

  <xsl:template match="specialite">
    <div id="{@id}" class="specialite">
      <h1>
        <xsl:value-of select="nom"/>
      </h1>
      <h2>Description</h2>
      <p>
        <xsl:value-of select="description"/>
      </p>
      <xsl:apply-templates select="responsables"/>
    </div>
    <xsl:apply-templates select="parcours"/>
  </xsl:template>

  <xsl:template match="unites">
    <div class="unites" id="unites">
      <h1>Liste des unités par références</h1>
      <xsl:for-each select="./unite">
        <xsl:sort select="@id"/>
        <a href="#{@id}" class="lien">
          <xsl:value-of select="@id"/>
        </a><xsl:text> </xsl:text>
      </xsl:for-each>
      <h1>Liste des unités par nom</h1>
      <table class="table table-striped">
        <xsl:for-each select="./unite">
          <xsl:sort select="nom"/>
          <tr>
            <td><xsl:value-of select="nom"/></td>
            <td><a href="#{@id}" class="lien"><xsl:value-of select="@id"/></a></td>
          </tr>
        </xsl:for-each>
      </table>
    </div>
    <xsl:for-each select="./unite">
      <div id="{@id}" class="unite">
        <h1>
          <xsl:value-of select="nom"/>
        </h1>
        <h2>Informations</h2>
        <h3>Credits</h3>
        <xsl:value-of select="credits"/>
        <h3>Résumé</h3>
        <xsl:value-of select="resume"/>
        <h3>Plan</h3>
        <ul>
          <xsl:for-each select="plan/item">
            <li>
              <xsl:value-of select="."/>
            </li>
          </xsl:for-each>
        </ul>
        <h3>Intervenants</h3>
        <xsl:for-each select="ref-intervenant">
          <li>
            <a href="#{@ref}" class="lien">
              <xsl:value-of select="/master/intervenants/intervenant[@id = current()/@ref]/nom"/>
            </a>
          </li>
        </xsl:for-each>
      </div>
    </xsl:for-each>
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
          <a href="#{@ref}" class="lien">
            <xsl:value-of select="/master/intervenants/intervenant[@id = current()/@ref]/nom"/>
          </a>
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
    <h4>
      <a href="#{@id}" class="lien"><xsl:value-of select="@id"/> : <xsl:value-of select="nom"/></a>
    </h4>
  </xsl:template>

  <xsl:template match="resume">
    <p>
      <xsl:value-of select="."/>
    </p>
  </xsl:template>

  <xsl:template name="faire-une-liste">
    <xsl:param name="objets"/>
    <xsl:param name="nom"/>
    <h4>
      <xsl:value-of select="$nom"/>
    </h4>
    <xsl:for-each select="$objets">
      <xsl:apply-templates select="." mode="ref"/>
    </xsl:for-each>
  </xsl:template>

  <!--
  <xsl:call-template name="faire-une-liste">
     <xsl:with-param name="objets" value="//unite[credits = 3]" />
     <xsl:with-param name="nom" value="Liste des UE de 3 crédits" />
  </xsl:call-template>
-->

  <!--
  <xsl:call-template name="faire-une-liste">
  <xsl:with-param name="objets" value="//[count(item) = 1 and item = &luminy;]" />
     <xsl:with-param name="nom" value="Intervenants n'enseignants qu'à Luminy" />
  </xsl:call-template>
-->

</xsl:stylesheet>
