<?xml version="1.0" encoding="utf-8" ?>

<xsl:stylesheet
   	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   	version="1.0"
   	>

	<xsl:output 
		method="xml"
		encoding="iso-8859-1"
		indent="yes"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"              
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
	/> 
	
	<xsl:variable
	    name="unites"
	    select="/master/unites/unite"
	   />
	   
	<xsl:template name="parcours-from-id" >
		<xsl:param name="id-unite" />
		<ul>
		<xsl:for-each select="//parcours">
			<xsl:if test="boolean(semestre/*/ref-unite/@idref = $id-unite)" >
				<li>
					<xsl:call-template name="faire-lien">
						<xsl:with-param name="href">parcours.html#<xsl:value-of select="@id" /></xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="nom" /></xsl:with-param>
					</xsl:call-template>
				</li>
			</xsl:if>
		</xsl:for-each>
		</ul>
	</xsl:template>
	
	
  	<!-- PARTIE AFFICHAGE De toutes les UE -->  	
	
	<xsl:template name="blockquote-id">
		<xsl:param name="elements" />
		<p>
			<xsl:for-each select="$elements">
				<xsl:sort select="@id"/>
			    <xsl:if test="position() > 1">, </xsl:if>				
				<xsl:call-template name="faire-lien" >
					<xsl:with-param name="href">unites/<xsl:value-of select="@id" />.html</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="@id" /></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</p>
	</xsl:template>
	
	<xsl:template name="table-id-nom">
		<xsl:param name="elements" />
		<table summary="Table associative id - nom">
			<thead>
				<tr>
					<th>Code</th>
					<th>Nom</th>
				</tr>
			</thead>
			<tbody>
				<xsl:for-each select="$elements">
					<xsl:sort select="nom" />
					<tr>
						<td><xsl:value-of select="@id" /></td>
						<td>
							<xsl:call-template name="faire-lien" >
								<xsl:with-param name="href">unites/<xsl:value-of select="@id" />.html</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="nom" /></xsl:with-param>
							</xsl:call-template>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
	</xsl:template>
	
	<xsl:template name="liste-des-unites" >
		<h1>Les unités d'enseignement</h1>
		<h2>Les unités triées par code</h2>
		<xsl:call-template name="blockquote-id">
			<xsl:with-param name="elements" select="$unites" />
		</xsl:call-template>		
		<h2>Les unités de Master</h2>
		<xsl:call-template name="table-id-nom">
			<xsl:with-param name="elements" select="$unites" />
		</xsl:call-template>
	</xsl:template>


	<!-- PARTIE AFFICHAGE D'UNE UE -->

	<xsl:template match="plan">
	    <xsl:if test="cours|td|tp">
	    <li>
			<b>
			<xsl:for-each select="*">
			    <xsl:if test="position() > 1"> / </xsl:if>
				<xsl:value-of select ="concat(translate(substring(local-name(), 1, 1), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'), substring(local-name(), 2))"/>
			</xsl:for-each>
			: </b>
			<xsl:for-each select="*">
			    <xsl:if test="position() > 1"> / </xsl:if>
				<xsl:value-of select="."/>h
			</xsl:for-each>
		</li>
		</xsl:if>
		
	</xsl:template>
	
	<xsl:template match="ref-intervenant">
		<h2>Intervenants</h2>
		<ul>
		<xsl:for-each select=".">
			<li>
			<xsl:call-template name="faire-lien">
				<xsl:with-param name="href">intervenants.html#<xsl:value-of select="id(@idref)/@id" /></xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="id(@idref)/prénom" />&#160;<xsl:value-of select="id(@idref)/nom" /></xsl:with-param>
			</xsl:call-template>
			</li>
		</xsl:for-each>
		</ul>
	</xsl:template>
	
	<xsl:template match="resume">
		<xsl:if test="*" >
			<h2>Description</h2>
			<b>Résumé:</b><br />
			<xsl:copy-of select="*" />
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="localisation">
		<li>
		<b>Localisation: </b>
		<xsl:for-each select="lieu">
		    <xsl:if test="position() > 1"> / </xsl:if>
			<xsl:value-of select="." />
		</xsl:for-each>
		</li>
	</xsl:template>
	
	<xsl:template match="credits">
		<li><b>Crédits: </b><xsl:value-of select="."/></li>
	</xsl:template>
	

	<xsl:template name="affichage-unites" >
		<xsl:for-each select="$unites">
		  	<xsl:document 
				href="unites/{@id}.html"
				method="xml"
				encoding="iso-8859-1"
				indent="yes"
				doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"              
				doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"  
			>
			<html>
		    	<head>
		    		<title><xsl:value-of select="@id" /> - <xsl:value-of select="nom" /></title>
		    	</head>
		    	<body>
					<h1 id="{@id}">
						Unité d'enseignement <xsl:value-of select="@id" />:<br />
						"<xsl:value-of select="nom" />"
					</h1>
					<ul>
						<xsl:apply-templates select="credits" />
						<xsl:apply-templates select="plan" />
						<xsl:apply-templates select="localisation" />
					</ul>
					<xsl:apply-templates select="resume" />
					
					
					<xsl:variable name="ReturnParcoursValue">
						<xsl:call-template name="parcours-from-id">
							<xsl:with-param name="id-unite" select="@id"/>
						</xsl:call-template>
					</xsl:variable>
					
					<xsl:if test="$ReturnParcoursValue != ''">
						<h2>Parcours</h2>
							<xsl:call-template name="parcours-from-id">
								<xsl:with-param name="id-unite" select="@id"/>
							</xsl:call-template>
					</xsl:if>
					
					<xsl:apply-templates select="ref-intervenant" />
		    	</body>
	    	</html>	
			</xsl:document>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>	