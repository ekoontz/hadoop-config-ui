<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html"/>
  <xsl:include href="head.xsl"/>
  <xsl:template match="configuration">
    <html>
      <head>
	<xsl:apply-templates select="." mode="head"/>
      </head>
      <body>
	<xsl:apply-templates select="property"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="property">
    <h1>property:<xsl:value-of select="name"/></h1>
    <xsl:call-template name="decompose">
      <xsl:with-param name="prefix" select="substring-before(name,'.')"/>
      <xsl:with-param name="suffix" select="substring-after(name,'.')"/>
      <xsl:with-param name="node"><xsl:copy-of select="value"/></xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="decompose">
    <xsl:param name="prefix"/>
    <xsl:param name="suffix"/>
    <xsl:param name="node"/>
    <xsl:if test="$prefix != ''">
      <table class="table table-striped table-condensed table-bordered decomposed">
	<tr>
	  <td><xsl:value-of select="$prefix"/></td>
	  <td>
	    <xsl:choose>
	      <xsl:when test="substring-before($suffix,'.')">
		<xsl:call-template name="decompose">
		  <xsl:with-param name="prefix" select="substring-before($suffix,'.')"/>
		  <xsl:with-param name="suffix" select="substring-after($suffix,'.')"/>
		  <xsl:with-param name="node"><xsl:copy-of select="$node"/></xsl:with-param>
		</xsl:call-template>
	      </xsl:when>
	      <xsl:otherwise>
                <td>		
		  <xsl:value-of select="$suffix"/>
		</td>
		<td>
		  <xsl:value-of select="$node"/>
		</td>
	      </xsl:otherwise>
	    </xsl:choose>
	  </td>
	</tr>
      </table>
    </xsl:if>
  </xsl:template>


</xsl:stylesheet>
