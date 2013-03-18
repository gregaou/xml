<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes" encoding="utf-8"
        doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
        omit-xml-declaration="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:variable name="title-gen"> - Département Informatique de Luminy</xsl:variable>

    <xsl:template match="/">
        <xsl:call-template name="intervenants"/>
        <xsl:call-template name="unites"/>
        <xsl:call-template name="specialites"/>
        <xsl:call-template name="index"/>
    </xsl:template>

    <!-- Début Génération du squelette (menu + header + parsing($selected) + footer) -->
    <xsl:template name="squelette">
        <xsl:param name="selected"/>
        <xsl:param name="title"/>
        <xsl:param name="path"/>
        <xsl:param name="call-template"/>
        <xsl:document href="{concat($path,'.html')}" method="xml" indent="yes" encoding="utf-8"
            doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
            doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
            omit-xml-declaration="yes">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="concat($title,$title-gen)"/>
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
                            <div class="span8" id="content">
                                <xsl:apply-templates select="$selected"/>
                            </div>
                        </div>
                    </div>
                    <script src="http://code.jquery.com/jquery-latest.js" type="text/javascript"/>
                    <script src="js/bootstrap.min.js" type="text/javascript"/>
                    <!--<script src="js/master.js" type="text/javascript"/>-->
                </body>
            </html>
        </xsl:document>
    </xsl:template>
    <!-- Fin Génération du squelette (menu + header + parsing($selected) + footer) -->

    <!-- Début Génération du menu -->
    <xsl:template name="menu">
        <ul class="nav nav-tabs nav-stacked" style="font-size: 12px;">
            <xsl:for-each select="//specialite">
                <xsl:sort select="./nom"/>
                <li>
                    <xsl:choose>
                        <xsl:when test="./nom">
                            <a href="{@id}.html" class="menunav">
                                <xsl:value-of select="./nom"/>
                            </a>
                            <ul class="nav nav-tabs nav-pills sousmenu">
                                <xsl:for-each select="./parcours">
                                    <li>
                                        <a href="{@id}.html" class="menunav">
                                            <xsl:value-of select="./nom"/>
                                        </a>
                                    </li>
                                </xsl:for-each>
                            </ul>
                        </xsl:when>
                        <xsl:otherwise>
                            <a href="{./parcours/@id}.html" class="menunav">
                                <xsl:value-of select="./parcours/nom"/>
                            </a>
                        </xsl:otherwise>
                    </xsl:choose>
                </li>
            </xsl:for-each>
            <li>
                <a href="intervenants.html" class="menunav">Intervenants</a>
            </li>
            <li>
                <a href="unites.html" class="menunav">Unités</a>
            </li>
        </ul>
    </xsl:template>
    <!-- Fin Génération du menu -->

    <xsl:template name="index">
        <xsl:document href="index.html" method="xml" indent="yes" encoding="utf-8"
            doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
            doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
            omit-xml-declaration="yes">
            <html>
                <head>
                    <title>Index</title>
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
                            <div class="span8 data" id="content">
                              <xsl:call-template name="faire-une-liste">
                                <xsl:with-param name="objets" select="//unite[credits = 3]/nom" />
                                <xsl:with-param name="nom" select="'Liste des UE de 3 crédits'" />
                              </xsl:call-template>

                              
                              <!-- TODO: Modifier unite pour gérer les lieux
                              <xsl:call-template name="faire-une-liste">
                                <xsl:with-param name="objets" value="//intervenants[//unite[count(lieu) = 1 and lieu=&luminy;]/@ref-intervenant=@id]" />
                              <xsl:with-param name="nom" value="Intervenants n'enseignants qu'à Luminy" />
                              -->
                            </div>
                        </div>
                    </div>
                    <script src="http://code.jquery.com/jquery-latest.js" type="text/javascript"/>
                    <script src="js/bootstrap.min.js" type="text/javascript"/>
                    <!--<script src="js/master.js" type="text/javascript"/>-->
                </body>
            </html>
        </xsl:document>
    </xsl:template>

    <!-- Début Génération de la page des intervenants -->
    <xsl:template name="intervenants">
        <xsl:call-template name="squelette">
            <xsl:with-param name="selected" select="//intervenants"/>
            <xsl:with-param name="title" select="'Intervenants'"/>
            <xsl:with-param name="path" select="'intervenants'"/>
        </xsl:call-template>
    </xsl:template>
    <xsl:template match="intervenants">
        <div id="intervenants" class="intervenants">
            <h1>Intervenants</h1>
            <table class="table table-striped" summary="Liste des intervenants">
                <tr>
                    <th>Personne</th>
                    <th>Email</th>
                    <th>Site Web</th>
                </tr>
                <xsl:for-each select="./intervenant">
                    <xsl:sort select="nom"/>
                    <tr>
                        <td>
                            <a href="{@id}.html" class="lien">
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
                    <xsl:call-template name="intervenant"/>
                </xsl:for-each>
            </table>
        </div>
    </xsl:template>
    <!-- Fin Génération de la page des intervenants -->

    <!-- Début Génération de la page de chaque intervenant -->
    <xsl:template name="intervenant">
        <xsl:call-template name="squelette">
            <xsl:with-param name="selected" select="."/>
            <xsl:with-param name="title" select="concat(./nom,' ',./prenom)"/>
            <xsl:with-param name="path" select="@id"/>
        </xsl:call-template>
    </xsl:template>
    <xsl:template match="intervenant">
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
                <ul>
                    <xsl:for-each
                        select="/master/unites/unite/ref-intervenant[@ref = current()/@id]">
                        <li>
                            <a href="{../@id}.html" class="lien">
                                <xsl:value-of select="../nom"/>
                            </a>
                        </li>
                    </xsl:for-each>
                </ul>
            </xsl:if>
            <xsl:if
                test="/master/specialite/responsables/ref-intervenant[@ref = current()/@id] or /master/specialite/parcours/responsables/ref-intervenant[@ref = current()/@id]">
                <h3>Responsables des parcours/specialités :</h3>
                <ul>
                    <xsl:for-each
                        select="/master/specialite/responsables/ref-intervenant[@ref = current()/@id]">
                        <li>
                            <a href="{../../@id}.html" class="lien">
                                <xsl:value-of select="../../nom"/>
                            </a>
                        </li>
                    </xsl:for-each>
                    <xsl:for-each
                        select="/master/specialite/parcours/responsables/ref-intervenant[@ref = current()/@id]">
                        <li>
                            <a href="{../../@id}.html" class="lien">
                                <xsl:value-of select="../../nom"/>
                            </a>
                        </li>
                    </xsl:for-each>
                </ul>
            </xsl:if>
        </div>
    </xsl:template>
    <!-- Fin Génération de la page de chaque intervenant -->

    <!-- Début Génération de la page des unités -->
    <xsl:template name="unites">
        <xsl:call-template name="squelette">
            <xsl:with-param name="selected" select="//unites"/>
            <xsl:with-param name="title" select="'Unités'"/>
            <xsl:with-param name="path" select="'unites'"/>
        </xsl:call-template>
    </xsl:template>
    <xsl:template match="unites">
        <div class="unites" id="unites">
            <h1>Liste des unités par références</h1>
            <span style="text-align: justify;">
                <xsl:for-each select="./unite">
                    <xsl:sort select="@id"/>
                    <a href="{@id}.html" class="lien">
                        <xsl:value-of select="@id"/>
                    </a>
                    <xsl:text> </xsl:text>
                </xsl:for-each>
            </span>
            <h1>Liste des unités par nom</h1>
            <table class="table table-striped" summary="Liste des unités">
                <xsl:for-each select="./unite">
                    <xsl:sort select="nom"/>
                    <tr>
                        <td>
                            <xsl:value-of select="nom"/>
                        </td>
                        <td>
                            <a href="{@id}.html" class="lien">
                                <xsl:value-of select="@id"/>
                            </a>
                        </td>
                    </tr>
                    <xsl:call-template name="unite"/>
                </xsl:for-each>
            </table>
        </div>
    </xsl:template>
    <!-- Fin Génération de la page des unités -->

    <!-- Début Génération de la page de chaque unité -->
    <xsl:template name="unite">
        <xsl:call-template name="squelette">
            <xsl:with-param name="selected" select="."/>
            <xsl:with-param name="title" select="./nom"/>
            <xsl:with-param name="path" select="@id"/>
        </xsl:call-template>
    </xsl:template>
    <xsl:template match="unite">
        <div id="{@id}" class="unite">
            <h1>
                <xsl:value-of select="nom"/>
            </h1>
            <h2>Informations</h2>
            <h3>Credits</h3>
            <xsl:value-of select="credits"/>
            <h3>Résumé</h3>
            <xsl:value-of select="resume"/>
            <xsl:if test="count(ref-intervenant) != 0">
                <h3>Intervenants</h3>
                <ul>
                    <xsl:for-each select="ref-intervenant">
                        <li>
                            <a href="{@ref}.html" class="lien">
                                <xsl:value-of
                                    select="/master/intervenants/intervenant[@id = current()/@ref]/nom"
                                />
                            </a>
                        </li>
                    </xsl:for-each>
                </ul>
            </xsl:if>
            <h3>Apparaît dans les parcours :</h3>
            <ul>
                <xsl:for-each select="//ref-structure[@ref = current()/@id]">
                    <xsl:choose>
                        <xsl:when test="name(../..) = 'semestre'">
                            <xsl:for-each select="//ref-semestre[@ref = current()/../../@id]">
                                <li>
                                    <a href="{../../@id}.html">
                                        <xsl:if test="../../../nom"><xsl:value-of select="../../../nom"/> / </xsl:if>
                                        <xsl:value-of select="../../nom"/>
                                    </a>
                                </li>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:for-each
                                select="//semestre/structure/ref-structure[@ref = current()/../../@id]">
                                <xsl:for-each select="//ref-semestre[@ref = current()/../../@id]">
                                    <li>
                                        <a href="{../../@id}.html">
                                            <xsl:if test="../../../nom"><xsl:value-of select="../../../nom"/> / </xsl:if>
                                            <xsl:value-of select="../../nom"/>
                                        </a>
                                    </li>
                                </xsl:for-each>
                            </xsl:for-each>
                        </xsl:otherwise>
                    </xsl:choose>

                </xsl:for-each>
            </ul>
        </div>
    </xsl:template>
    <!-- Fin Génération de la page de chaque unité -->

    <!-- Début Génération de la page de chaque spécialité/parcours -->
    <xsl:template name="specialites">
        <xsl:for-each select="//specialites/specialite">
            <xsl:choose>
                <xsl:when test="./nom">
                    <xsl:call-template name="squelette">
                        <xsl:with-param name="selected" select="."/>
                        <xsl:with-param name="title" select="./nom"/>
                        <xsl:with-param name="path" select="@id"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="squelette">
                        <xsl:with-param name="selected" select="./parcours"/>
                        <xsl:with-param name="title" select="./parcours/nom"/>
                        <xsl:with-param name="path" select="./parcours/@id"/>
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>

        </xsl:for-each>
    </xsl:template>
    <xsl:template match="specialite">
        <div id="{@id}" class="specialite">
            <h1>
                <xsl:value-of select="nom"/>
            </h1>
            <xsl:if test="string(description) != ''">
            <h2>Description</h2>
            <p>
                <xsl:value-of select="description"/>
            </p>
            </xsl:if>
            <xsl:apply-templates select="responsables"/>
        </div>
        <xsl:for-each select="./parcours">
            <xsl:call-template name="squelette">
                <xsl:with-param name="selected" select="."/>
                <xsl:with-param name="title" select="./nom"/>
                <xsl:with-param name="path" select="@id"/>
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="parcours">
        <div id="{@id}" class="parcours">
            <xsl:choose>
                <xsl:when test="../nom">
                    <h1>
                        <xsl:value-of select="../nom"/>
                    </h1>
                    <h2>Parcours : <xsl:value-of select="nom"/></h2>
                </xsl:when>
                <xsl:otherwise>
                    <h1>
                        <xsl:value-of select="nom"/>
                    </h1>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="string(description) != ''">
            <h2>Description</h2>
            <p>
                <xsl:value-of select="description"/>
            </p>
            </xsl:if>
            <xsl:apply-templates select="responsables"/>
            <xsl:apply-templates select="debouches"/>
            <xsl:apply-templates select="lieux"/>
            <xsl:apply-templates select="ref-semestres"/>
        </div>
    </xsl:template>
    <xsl:template match="responsables">
    <xsl:if test="ref-intervenant">
        <h2>Responsables</h2>
        <ul>
            <xsl:for-each select="ref-intervenant">
                <li>
                    <a href="{@ref}.html" class="lien">
                        <xsl:value-of
                            select="/master/intervenants/intervenant[@id = current()/@ref]/nom"/>
                    </a>
                </li>
            </xsl:for-each>
        </ul>
    </xsl:if>
    </xsl:template>
    <xsl:template match="lieux">
    	<xsl:if test="string(lieux) != ''">
        <h2>Lieux</h2>
        <p>
        	<xsl:value-of select="."/>
        </p>
      </xsl:if>
    </xsl:template>
    <xsl:template match="debouches">
    	<xsl:if test="string(debouches) != ''">
        <h2>Débouchés</h2>
        <p>
        	<xsl:value-of select="."/>
        </p>
    	</xsl:if>
    </xsl:template>
    <xsl:template match="ref-semestres">
        <xsl:for-each select="./ref-semestre">
            <xsl:apply-templates select="//*[@id = current()/@ref]"/>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="semestre">
        <h3>
            <xsl:value-of select="./nom"/>
        </h3>
        <h5>
            <xsl:value-of select="./credits"/> credit<xsl:if test="number(./credits) > 1"
            >s</xsl:if></h5>
        <ul>
            <li>
                <h4>UE(s) Obligatoires</h4>
            </li>
            <xsl:if test="./structure/ref-structure">
            <li>
	           <xsl:for-each select="./structure/ref-structure">
                <xsl:variable name="type">
                    <xsl:value-of select="name(//*[@id = current()/@ref])"/>
                </xsl:variable>
                <xsl:if test="$type = 'unite'">
                    <xsl:call-template name="s_unite"/>
                </xsl:if>
            </xsl:for-each>
            </li>
            </xsl:if>
					</ul>
        <xsl:call-template name="ref-structure"/>
    </xsl:template>
    <xsl:template name="ref-structure">
	      <xsl:for-each select="./structure/ref-structure">
            <xsl:variable name="type">
                <xsl:value-of select="name(//*[@id = current()/@ref])"/>
            </xsl:variable>
            <xsl:choose>
                <xsl:when test="$type = 'unite' and name(../..) != 'semestre'">
                    <li class="list-deco"><xsl:call-template name="s_unite"/></li>
                </xsl:when>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="$type = 'groupe'">
                    <xsl:call-template name="s_groupe"/>
                </xsl:when>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="$type = 'option'">
                    <xsl:call-template name="s_option"/>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="s_unite">
        <ul>
            <xsl:for-each select="//unite[@id = current()/@ref]">

                <li>
                    <a href="{@id}.html"><xsl:value-of select="./nom"/> (<xsl:value-of
                            select="./credits"/> credit<xsl:if test="number(./credits) > 1"
                            >s</xsl:if>)</a>
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>
    <xsl:template name="s_groupe">
        <xsl:for-each select="//groupe[@id = current()/@ref]">
            <ul>
                <li>
                    <h4><xsl:value-of select="./nom"/> (<xsl:value-of select="./credits"/>
                            credit<xsl:if test="number(./credits) > 1">s</xsl:if>)</h4>
                </li>
                <xsl:call-template name="ref-structure"/>
            </ul>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="s_option">
        <xsl:for-each select="//option[@id = current()/@ref]">
            <ul>
                <li>
                    <h4><xsl:value-of select="./nom"/> (<xsl:value-of select="./credits"/>
                            credit<xsl:if test="number(./credits) > 1">s</xsl:if>)</h4>
                </li>
                <xsl:call-template name="ref-structure"/>
            </ul>
        </xsl:for-each>
    </xsl:template>
    <!-- Fin Génération de la page de chaque spécialité/parcours -->


    <!--<xsl:template match="ref-unite">
        <xsl:apply-templates select="/master/unites/unite[@id = current()/@ref]"/>
    </xsl:template>

    <xsl:template match="unite">
        <h4>
            <a href="#{@id}" class="lien"><xsl:value-of select="@id"/> : <xsl:value-of select="nom"
                /></a>
        </h4>
    </xsl:template>-->

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
        <ul>
        <xsl:for-each select="$objets">
            <li><xsl:apply-templates select="." mode="ref"/></li>
        </xsl:for-each>
        </ul>
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
