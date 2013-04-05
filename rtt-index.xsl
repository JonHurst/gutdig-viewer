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
      <script type="text/javascript" src="index.js"></script>
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
      <div class="index">
        <h1>Macroformatting</h1>
        <xsl:call-template name="macroformatting"/>
      </div>
      <div class="index">
        <h1>Multiple microformatting</h1>
        <xsl:call-template name="multimicro"/>
      </div>
      <div class="index">
        <h1>Page Notes</h1>
        <xsl:call-template name="notes"/>
      </div>
    </body>
  </html>
</xsl:template>


<xsl:template name="notes">
  <table summary="Pages with macroformatting">
    <xsl:for-each select="pages/page">
      <xsl:if test="notes">
        <tr><th><a class="page_ref">
          <xsl:attribute name="href">#</xsl:attribute>
          <xsl:value-of select="@id"/>
        </a></th>
          <td>
            <xsl:for-each select="notes">
              <ul class="note_block">
                <xsl:for-each select="note">
                  <li><xsl:value-of select="."/></li>
                </xsl:for-each>
              </ul>
            </xsl:for-each>
        </td></tr>
      <xsl:call-template name="image_row"/>
      </xsl:if>
    </xsl:for-each>
  </table>
</xsl:template>


<xsl:template name="macroformatting">
  <table summary="Pages with macroformatting">
    <xsl:for-each select="pages/page">
      <xsl:if test="tags[@class='block_formatting']">
        <tr>
          <th><a class="page_ref">
            <xsl:attribute name="href">#</xsl:attribute>
          <xsl:value-of select="@id"/></a></th>
          <td><xsl:apply-templates select="tags[@class='block_formatting']"/></td>
        </tr>
      </xsl:if>
      <xsl:call-template name="image_row"/>
    </xsl:for-each>
  </table>
</xsl:template>


<xsl:template name="multimicro">
  <table summary="Pages with multiple microformatting tags">
    <xsl:for-each select="pages/page">
      <xsl:if test="count(tags[@class='inline_formatting']/tag) > 1">
        <tr>
          <th><a class="page_ref">
            <xsl:attribute name="href">#</xsl:attribute>
          <xsl:value-of select="@id"/></a></th>
          <td><xsl:apply-templates select="tags[@class='inline_formatting']"/></td>
        </tr>
      <xsl:call-template name="image_row"/>
      </xsl:if>
    </xsl:for-each>
  </table>
</xsl:template>


<xsl:template name="image_row">
  <tr class="image_row folded"><td colspan="2">
    <a class="img_link">
      <xsl:attribute name="href">
        <xsl:value-of select="$baseURI"/>images/<xsl:value-of select="@id"/>
        <xsl:text>.png</xsl:text>
      </xsl:attribute>
    </a>
  </td></tr>
</xsl:template>


<xsl:template match="tags">
    <ul><xsl:apply-templates/></ul>
</xsl:template>


<xsl:template match="tag">
  <li class="tag"><xsl:value-of select="."/></li>
</xsl:template>

</xsl:stylesheet>