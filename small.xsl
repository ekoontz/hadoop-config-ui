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
	<ul>
	  <xsl:apply-templates select="property" mode="summary"/>
	</ul>
	<xsl:apply-templates select="property" mode="nested"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="property" mode="summary">
    <li><xsl:value-of select="name"/></li>
  </xsl:template>

  <xsl:template match="property" mode="nested">
    <xsl:param name="prefix" select="substring-before(name,'.')"/>
    <xsl:param name="prefix_path"/>
    <xsl:param name="common_prefix"/>
    <xsl:param name="suffix" select="substring-after(name,'.')"/>
    <xsl:variable name="property" select="name"/>
    <xsl:variable name="new_prefix_path">
      <xsl:choose>
	<xsl:when test="$prefix_path != ''">
	  <xsl:value-of select="concat($prefix_path,'.',$prefix)"/>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:value-of select="$prefix"/>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="$prefix != ''">
      <xsl:choose>
	<xsl:when test="$prefix = $common_prefix">
	  <!-- skip this prefix and continue to next. -->
	  <xsl:apply-templates select="." mode="nested"> 
	    <xsl:with-param name="prefix" select="substring-before($suffix,'.')"/>
	    <xsl:with-param name="suffix" select="substring-after($suffix,'.')"/>
	    <xsl:with-param name="common_prefix" select="$common_prefix"/>
	    <xsl:with-param name="prefix_path" select="new_prefix_path"/>
	  </xsl:apply-templates>
	</xsl:when>
	<xsl:when test="$prefix != ''">
	  <table class="table table-striped table-condensed table-bordered decomposed">
	    <tr>
	      <td>
		<h3><xsl:value-of select="$prefix"/></h3>
	      </td>
	      <xsl:choose>
		<xsl:when test="substring-before($suffix,'.')">
		  <xsl:apply-templates select="." mode="nested">
		    <xsl:with-param name="prefix" select="substring-before($suffix,'.')"/>
		    <xsl:with-param name="prefix_path" select="$new_prefix_path"/>
		    <xsl:with-param name="suffix" select="substring-after($suffix,'.')"/>
		    <xsl:with-param name="common_prefix" select="$common_prefix"/>
		  </xsl:apply-templates>
		</xsl:when>
		<xsl:otherwise>
		  <td>
		    <h3><xsl:value-of select="$suffix"/></h3>
		  </td>
		  <td>
		    <xsl:value-of select="value"/>
		  </td>
		</xsl:otherwise>
	      </xsl:choose>
	    </tr>
	    <xsl:apply-templates select="following-sibling::property" mode="filter">
	      <xsl:with-param name="prefix" select="$new_prefix_path"/>
	    </xsl:apply-templates>
	  </table>
	</xsl:when>
      </xsl:choose>
    </xsl:if>
  </xsl:template>

  <xsl:template match="property" mode="filter">
    <xsl:param name="prefix"/>

    <xsl:if test="starts-with(name,$prefix)">
      <xsl:variable name="suffix" select="substring-after(substring-after(name,$prefix),'.')"/>
      <tr>
	<td>
	  <!-- <xsl:value-of select="preceding-sibling::property/name"/> -->
	</td>
	<td>
	  <h3><xsl:value-of select="$suffix"/></h3>
	</td>
	<td>
	  <xsl:value-of select="value"/>
	</td>
      </tr>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
