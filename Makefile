all: pride-and-prejudice.html frankenstein-1818.html sherlock-adventures.html huckfinn.html frankenstein-1831.html

pride-and-prejudice.html: rtt.xsl ../dig/pride-and-prejudice/rtt.xml ../dig/pride-and-prejudice/text/*
	xsltproc --xinclude --stringparam baseURI "../dig/pride-and-prejudice/" rtt.xsl ../dig/pride-and-prejudice/rtt.xml > pride-and-prejudice.html

frankenstein-1818.html: rtt.xsl ../dig/frankenstein-1818/rtt.xml ../dig/frankenstein-1818/text/*
	xsltproc --xinclude --stringparam baseURI "../dig/frankenstein-1818/" rtt.xsl ../dig/frankenstein-1818/rtt.xml > frankenstein-1818.html

sherlock-adventures.html: rtt.xsl ../dig/sherlock-adventures/rtt.xml ../dig/sherlock-adventures/text/*
	xsltproc --xinclude --stringparam baseURI "../dig/sherlock-adventures/" rtt.xsl ../dig/sherlock-adventures/rtt.xml > sherlock-adventures.html

huckfinn.html: rtt.xsl ../dig/huckfinn/rtt.xml ../dig/huckfinn/text/*
	xsltproc --xinclude --stringparam baseURI "../dig/huckfinn/" rtt.xsl ../dig/huckfinn/rtt.xml > huckfinn.html

frankenstein-1831.html: rtt.xsl ../dig/frankenstein-1831/rtt.xml ../dig/frankenstein-1831/text/*
	xsltproc --xinclude --stringparam baseURI "../dig/frankenstein-1831/" rtt.xsl ../dig/frankenstein-1831/rtt.xml > frankenstein-1831.html
