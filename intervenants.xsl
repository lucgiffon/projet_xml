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
	    name="intervenants"
	    select="/master/intervenants/intervenant"
	   />  	
	
	<xsl:template name="unite-from-id-intervenant">
		<xsl:param name="id-intervenant" />
		<ul>
		<xsl:for-each select="//unite">
	
			<xsl:if test="boolean(ref-intervenant/@idref = $id-intervenant)" >
				<li>
					<xsl:call-template name="faire-lien">
						<xsl:with-param name="href">unites.html#<xsl:value-of select="@id" /></xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="nom" /></xsl:with-param>
					</xsl:call-template>
				</li>
			</xsl:if>
		</xsl:for-each>
		</ul>
	</xsl:template>


  	<!-- PARTIE AFFICHAGE De tous les intervenants -->  

	<xsl:template name="table-intervenants">
		<xsl:param name="elements" />
		<table summary="Table associative des intervenants">
			<thead>
				<tr>
					<th>Code</th>
					<th>Nom</th>
					<th>Courriel</th>
					<th>Web</th>
				</tr>
			</thead>
			<tbody>
				<xsl:for-each select="$elements">
					<xsl:sort select="nom" />
					<tr>
						<td><xsl:value-of select="@id" /></td>
						<td>
							<xsl:call-template name="faire-lien" >
								<xsl:with-param name="href">intervenants/<xsl:value-of select="@id" />.html</xsl:with-param>
								<xsl:with-param name="value">
									<xsl:value-of select="nom" />&#160;<xsl:value-of select="prénom" />
								</xsl:with-param>
							</xsl:call-template>
						</td>
						<td><xsl:value-of select="mail" /></td>
						<td><xsl:value-of select="site" /></td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
	</xsl:template>

	<xsl:template name="liste-des-intervenants" >
		<h1>Les intervenants du Master Informatique</h1>
		<h2>Liste</h2>
		<xsl:call-template name="table-intervenants">
			<xsl:with-param name="elements" select="$intervenants" />
		</xsl:call-template>
	</xsl:template>
	
	
	<!-- PARTIE AFFICHAGE d'un intervenants -->  	
	
	<xsl:template name="affichage-intervenants" >
		<xsl:for-each select="$intervenants">
			<xsl:document 
					href="intervenants/{@id}.html"
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
							Fiche de <br />
							<xsl:value-of select="prénom" />&#160;<xsl:value-of select="nom" />
						</h1> 
						<h2>Présentation</h2>
							<xsl:if test="mail" >
								<b>Adresse email: </b>
								<xsl:call-template name="faire-lien">
									<xsl:with-param name="href">mailto:<xsl:value-of select="mail" /></xsl:with-param>
									<xsl:with-param name="value"><xsl:value-of select="mail" /></xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<br />
							<xsl:if test="site" >
								<b>Site Internet: </b>
								<xsl:call-template name="faire-lien">
									<xsl:with-param name="href"><xsl:value-of select="site" /></xsl:with-param>
									<xsl:with-param name="value"><xsl:value-of select="site" /></xsl:with-param>
								</xsl:call-template>
							</xsl:if>
						
							<xsl:variable name="ReturnIntervenantValue">
								<xsl:call-template name="unite-from-id-intervenant">
									<xsl:with-param name="id-intervenant" select="@id"/>
								</xsl:call-template>
							</xsl:variable>
			 					 		
							<xsl:if test="$ReturnIntervenantValue != ''">
								<h2>Unités Enseignées</h2>
								<xsl:call-template name="unite-from-id-intervenant">
									<xsl:with-param name="id-intervenant" select="@id"/>
								</xsl:call-template>
							</xsl:if>
				    	</body>
		    		</html>	
				</xsl:document>					
		</xsl:for-each>
	</xsl:template>
	
</xsl:stylesheet>