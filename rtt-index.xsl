<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.w3.org/1999/xhtml">

<xsl:output method="xml"
	    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	    doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	    version="1.0" encoding="utf-8"/>

<xsl:param name="target"></xsl:param>

<xsl:template match="book">
  <html>
    <head>
      <title><xsl:value-of select="title"/>
      <xsl:if test="subtitle">: <xsl:value-of select="subtitle"/></xsl:if></title>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      <link rel="stylesheet" type="text/css" href="styles.css"/>
      <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
      <!-- <script type="text/javascript" src="script.js"></script> -->
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
        <h1>Page notes</h1>
        <xsl:call-template name="note_block"/>
      </div>
      <div class="index">
        <h1>Global notes</h1>
        <xsl:call-template name="global_note_block"/>
      </div>
    </body>
  </html>
</xsl:template>


<xsl:template name="macroformatting">
  <table summary="Pages with macroformatting">
    <xsl:for-each select="pages/page">
      <xsl:if test="tags[@class='block_formatting']">
        <tr>
          <th><a>
            <xsl:attribute name="href"><xsl:value-of select="$target"/>#pg<xsl:value-of
            select="@id"/></xsl:attribute>
          <xsl:value-of select="@id"/></a></th>
          <td><xsl:apply-templates select="tags[@class='block_formatting']"/></td>
        </tr>
      </xsl:if>
    </xsl:for-each>
  </table>
</xsl:template>


<xsl:template name="multimicro">
  <table summary="Pages with multiple microformatting tags">
    <xsl:for-each select="pages/page">
      <xsl:if test="count(tags[@class='inline_formatting']/tag) > 1">
        <tr>
          <th><a>
            <xsl:attribute name="href"><xsl:value-of select="$target"/>#pg<xsl:value-of
            select="@id"/></xsl:attribute>
          <xsl:value-of select="@id"/></a></th>
          <td><xsl:apply-templates select="tags[@class='inline_formatting']"/></td>
        </tr>
      </xsl:if>
    </xsl:for-each>
  </table>
</xsl:template>


<xsl:template name="note_block">
  <table summary="Pages with notes">
    <xsl:for-each select="pages/page">
      <xsl:for-each select="notes">
        <tr>
          <th><a>
            <xsl:attribute name="href"><xsl:value-of select="$target"/>#pg<xsl:value-of
            select="../@id"/></xsl:attribute>
          <xsl:value-of select="../@id"/></a></th>
          <td>
            <ul>
              <xsl:for-each select="note">
                <li><xsl:value-of select="."/></li>
              </xsl:for-each>
            </ul>
          </td>
        </tr>
      </xsl:for-each>
    </xsl:for-each>
  </table>
</xsl:template>


<xsl:template name="global_note_block">
  <xsl:for-each select="notes">
    <div class="note_block"><ul>
      <xsl:for-each select="note">
        <li><xsl:value-of select="."/></li>
      </xsl:for-each>
    </ul>
    </div>
  </xsl:for-each>
</xsl:template>


<xsl:template match="tags">
    <ul><xsl:apply-templates/></ul>
</xsl:template>


<xsl:template match="tag">
  <li><xsl:value-of select="."/></li>
</xsl:template>

</xsl:stylesheet>