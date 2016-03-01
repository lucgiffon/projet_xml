XSLT = xsltproc
LINT = xmllint --noout


# all: clean gen dtd xsd web xq tidy java
all: clean dtd web tidy


gen: donnees-to-xml.xsl donnees-master.xml
	# @echo "\nConstruction du fichier de données XML"
	$(XSLT) donnees-to-xml.xsl donnees-master.xml
	
	
dtd: tp4.xml tp4.dtd
	# @echo "\nValidation avec la DTD"
	$(LINT) --valid  tp4.xml


xsd: master-gen.xml master-schema.xsd
	# @echo "\nValidation avec le schema"
	$(LINT) --schema  master-schema.xsd master-gen.xml
	

web: tp4.xml tp4.xsl
	# @echo "\nGénération du dossier www/"
	@mkdir www
	$(XSLT) tp4.xsl tp4.xml
	
	
tidy: www/
	# @echo "\nValidation des fichiers www./*.html"
	tidy -ascii -imqe -ashtml www/*
	tidy -ascii -imqe -ashtml www/unites/*
	tidy -ascii -imqe -ashtml www/intervenants/*
	# @echo "\nValidation de la documentation"
	# tidy -ascii -imqe -asxhtml documentation.html


xq:
	@echo "\nCréation de la requête XQuery"
	java -cp Outils/saxon9he.jar net.sf.saxon.Query !indent=yes xq.txt > www/xq.html


java:
	@echo "\nCréation du fichier DOM"
	javac CreateDom.java
	java CreateDom > dom.txt
	@echo "\n"


clean:
	# @echo "\nSuppression"
	rm -rf www/