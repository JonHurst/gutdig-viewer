<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.w3.org/1999/xhtml">

<xsl:output method="xml"
	    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	    doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	    version="1.0" encoding="utf-8"/>

<xsl:param name="baseURI">.</xsl:param>

<xsl:template match="book">
  <html>
    <head>
      <title><xsl:value-of select="title"/>
      <xsl:if test="subtitle">: <xsl:value-of select="subtitle"/></xsl:if></title>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      <link rel="stylesheet" type="text/css" href="styles.css"/>
      <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
      <script type="text/javascript" src="script.js"></script>
    </head>
    <body>
      <div id="title">
        <h1><xsl:value-of select="title"/>
        <xsl:if test="subtitle">
          <br/><span class="smaller"><xsl:value-of select="subtitle"/></span>
        </xsl:if>
        </h1>
        <p>by</p>
        <h2><xsl:value-of select="author"/></h2>
      </div>
      <div id="loading">
        <p>Loading…</p>
      </div>
      <div id="pages">
      <xsl:for-each select="notes">
        <div class="note_block"><ul>
          <xsl:for-each select="note">
            <li>
              <xsl:if test="@line">
                <xsl:value-of select="@line"/>
                <xsl:text>: </xsl:text>
              </xsl:if>
            <xsl:value-of select="."/></li>
          </xsl:for-each>
        </ul>
        </div>
      </xsl:for-each>
        <xsl:apply-templates select="pages"/>
      </div>
    </body>
  </html>
</xsl:template>


<xsl:template match="page">
  <table class="page">
    <xsl:attribute name="id">
      <xsl:text>pg</xsl:text><xsl:value-of select="@id"/>
    </xsl:attribute>
    <xsl:if test="tags[@class='block_formatting']">
      <xsl:attribute name="class">page block_formatting</xsl:attribute>
    </xsl:if>
    <tr><th colspan="3">Page <xsl:value-of select="@id"/></th></tr>
    <xsl:apply-templates select="tags"/>
    <xsl:if test="notes">
      <tr class="notes">
        <td colspan="3">
          <ul>
          <xsl:for-each select="notes/note">
            <li><xsl:value-of select="."/></li>
          </xsl:for-each>
          </ul>
        </td>
      </tr>
    </xsl:if>
    <tr>
    <xsl:apply-templates select="image"/>
    <td class="lnum"></td>
    <xsl:apply-templates select="text"/>
    </tr>
  </table>
</xsl:template>


<xsl:template match="tags">
  <tr class="formatting"><td colspan="3">
    <ul><xsl:apply-templates/></ul>
  </td></tr>
</xsl:template>


<xsl:template match="tag">
  <li><xsl:value-of select="."/></li>
</xsl:template>


<xsl:template match="image">
    <td class="img_ph">
      <a class='img_link'>
      <xsl:attribute name="href">
        <xsl:value-of select="$baseURI"/><xsl:value-of select="@src"/>
      </xsl:attribute>
      <xsl:text>Show</xsl:text>
      <br/>
      <xsl:text>image</xsl:text>
    </a></td>
</xsl:template>


<xsl:template match="text">
  <td class="text">
    <p><xsl:value-of select="."/></p>
  </td>
</xsl:template>

</xsl:stylesheet>