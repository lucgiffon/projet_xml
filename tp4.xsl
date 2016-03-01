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

  	<xsl:template name="faire-lien">
  		<xsl:param name="href" />
  		<xsl:param name="value" />
		<a href="{$href}"><xsl:copy-of select="$value"/></a> 
  	</xsl:template>

	<xsl:template match="/">
		<xsl:call-template name="master" />		
		<xsl:call-template name="gen-unites" />		
		<xsl:call-template name="gen-intervenants" />		
		<xsl:call-template name="gen-parcours" />		
	</xsl:template>		
  	
	<xsl:template name="master">
		<xsl:document 
			href="www/index.html"
			method="xml"
			encoding="iso-8859-1"
			indent="yes"
			doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"              
			doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"  
		>
	    	<html>
		    	<head>
		    		<title>TP4</title>
		    	</head>
		    	<body>
					Index du site
		    	</body>
	    	</html>
		</xsl:document>    	
  	</xsl:template>
  	
  	<xsl:template name="gen-unites">
	  	<xsl:document 
				href="www/unites.html"
				method="xml"
				encoding="iso-8859-1"
				indent="yes"
				doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"              
				doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"  
			>
	    	<html>
		    	<head>
		    		<title>Unites</title>
		    	</head>
		    	<body>
	   				<xsl:call-template name="liste-des-unites" />
					<xsl:call-template name="affichage-unites" />
		    	</body>
	    	</html>			
		</xsl:document>
  	</xsl:template>
  	
  	<xsl:template name="gen-intervenants">
	  	<xsl:document 
				href="www/intervenants.html"
				method="xml"
				encoding="iso-8859-1"
				indent="yes"
				doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"              
				doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"  
			>
	    	<html>
		    	<head>
		    		<title>Intervenants</title>
		    	</head>
		    	<body>
					<xsl:call-template name="liste-des-intervenants" />
					<xsl:call-template name="affichage-intervenants" />
		    	</body>
	    	</html>
		</xsl:document>  		
  	</xsl:template>
  	
  	<xsl:template name="gen-parcours">
	  	<xsl:document 
				href="www/parcours.html"
				method="xml"
				encoding="iso-8859-1"
				indent="yes"
				doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"              
				doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"  
			>
	    	<html>
		    	<head>
		    		<title>Parcours</title>
		    	</head>
		    	<body>
					<xsl:call-template name="liste-des-parcours" />
					<xsl:call-template name="affichage-parcours" />
		    	</body>
	    	</html>
		</xsl:document>  		
  	</xsl:template>  	
  	
  	<xsl:include href="unites.xsl" />
  	<xsl:include href="intervenants.xsl" />
  	<xsl:include href="parcours.xsl" />
  	
</xsl:stylesheet>
  	
  	



	
