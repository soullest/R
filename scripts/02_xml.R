url = "../data/tema1/cd_catalog.xml"
xmldoco = xmlParse(url)
rootNode = xmlRoot(xmldoco)
rootNode[1]
cd_data =xmlSApply(rootNode,function(x) xmlSApply(x, xmlValue))
cds.catalog =data.frame(t(cd_data),row.names = NULL)
cds.catalog[1:5,1:4]

popurl = "../data/tema1/WorldPopulation-wiki.htm"
tables = readHTMLTable(popurl)
most_populated=tables[[6]]

custom_table = readHTMLTable(popurl, which=6)
