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
	    name="parcours"
	    select="/master/cursus/parcours"
   	/> 
  	<!-- PARTIE AFFICHAGE De tous les intervenants -->  

	<xsl:template name="table-parcours">
		<xsl:param name="elements" />
		<table summary="Table des Parcours">
			<thead>
				<tr>
					<th>Master Informatique</th>
				</tr>
				<tr>
					<th>Parcours</th>
					<th>Code</th>
					<th>Année</th>
				</tr>
			</thead>
			<tbody>
				<xsl:for-each select="$elements">
					<xsl:sort select="semestre/numero" />
					<tr>
						<td>
							<xsl:call-template name="faire-lien" >
								<xsl:with-param name="href">parcours/<xsl:value-of select="@id" />.html</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="nom" /></xsl:with-param>
							</xsl:call-template>						
						</td>
						<td><xsl:value-of select="@id" /></td>
						<xsl:if test="semestre/numero[text()='3']">
							<td>M2</td>
						</xsl:if>
						<xsl:if test="semestre/numero[text()='1']">
							<td>M1</td>
						</xsl:if>
						
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
	</xsl:template>

	<xsl:template name="liste-des-parcours" >
		<h1>Les parcours du Master Informatique</h1>
		<xsl:call-template name="table-parcours">
			<xsl:with-param name="elements" select="$parcours" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="obligatoires|optionnelles">
		<li>Unités <xsl:value-of select="name(.)" /></li>
		<ul>
			<xsl:for-each select="*">
				<xsl:value-of select="id(@idref)/nom" /><br />				
			</xsl:for-each>
		</ul>
	</xsl:template>

	<!-- PARTIE AFFICHAGE d'un intervenants -->  	
	
	<xsl:template name="affichage-parcours" >
		<xsl:for-each select="$parcours">
			<xsl:document 
					href="parcours/{@id}.html"
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
							<xsl:value-of select="nom" />
						</h1> 
						<h2>Présentation et Objectifs</h2>
							<b>Responsable: </b>
								<xsl:call-template name="faire-lien">
									<xsl:with-param name="href">../intervenants/<xsl:value-of select="ref-responsable/@idref" /></xsl:with-param> 
									<xsl:with-param name="value">
										<xsl:value-of select="id(ref-responsable/@idref)/nom" />&#160;<xsl:value-of select="id(ref-responsable/@idref)/prénom" />
									</xsl:with-param>
								</xsl:call-template><br />
						<xsl:apply-templates select="resume" />
						<xsl:for-each select="semestre">
							<p><b>Programmes du semestre S<xsl:value-of select="numero" />:</b></p>
							<ul>
								<xsl:apply-templates select="obligatoires|optionnelles" />
								
								<li></li>
							</ul>				
						</xsl:for-each>
		    		</body>
		    		</html>	
				</xsl:document>					
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>
  	
  	



	
