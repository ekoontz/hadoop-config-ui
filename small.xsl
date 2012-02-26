<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html"/>
  <xsl:include href="head.xsl"/>

  <xsl:key name="prefix1" match="configuration/property/name" use="substring-before(.,'.')"/>
  <xsl:key name="prefix2" match="configuration/property/name" use="substring-before(substring-after(.,'.'),'.')"/>
  <xsl:key name="prefix3" match="configuration/property/name" use="substring-before(substring-after(substring-after(.,'.'),'.'),'.')"/>

  <xsl:template match="configuration">
    <html>
      <head>
	<xsl:apply-templates select="." mode="head"/>
	<style>
	  table.conf {
	  width:75%;
	  }
	  table.conf th,td {
	  border:1px dashed green;
	  }
	</style>

      </head>
      <body>
<!--	<xsl:apply-templates select="property" mode="summary"/> -->
	<xsl:apply-templates select="." mode="table"/>
	<xsl:apply-templates select="." mode="mock-table"/>
<!--	<xsl:apply-templates select="property[1]" mode="nested"/> -->
      </body>
    </html>
  </xsl:template>

  <xsl:template match="configuration" mode="table">
    <table class="table table-striped table-condensed table-bordered conf">
      <tr>
	<th rowspan="8">a(CS):<xsl:value-of select="'8'"/></th><td>40</td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="configuration" mode="mock-table">
    <table class="table table-striped table-condensed table-bordered conf">
      <tr>
	<th rowspan="8">a</th><td>40</td>
      </tr>
      <tr>
	<th rowspan="5">b</th>
      </tr>
      <tr>
	<th>c</th>
	<td>42</td>
      </tr>
      <tr>
	<th rowspan="2">d</th>
	<td>43</td>
      </tr>
      <tr>
	<th>g</th>
	<td>41</td>
      </tr>
      <tr>
	<th>e</th>
	<td>44</td>
      </tr>
      <tr>
	<th rowspan="2">c</th>
      </tr>
      <tr>
	<th>f</th>
	<td>45</td>
      </tr>
      <tr>
	<th>b</th>
	<td>46</td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="property" mode="summary">
    <xsl:variable name="prefix1" select="substring-before(name,'.')"/>
    <xsl:variable name="prefix2" select="substring-before(substring-after(name,'.'),'.')"/>
    <xsl:variable name="prefix3" select="substring-before(substring-after(substring-after(name,'.'),'.'),'.')"/>
    <li>
      <div style="border:dashed green 2px">
      <h2>PROP:<xsl:value-of select="name"/></h2>
	<h3>P1:<xsl:value-of select="$prefix1"/></h3>
	<ul>
	  <xsl:for-each select="key('prefix1',$prefix1)">
	    <li><xsl:value-of select="."/></li>
	  </xsl:for-each>
	</ul>
	<xsl:if test="$prefix2 != ''">
	  <h3>P2:<xsl:value-of select="$prefix2"/></h3>
	  <ul>
	    <xsl:for-each select="key('prefix2',$prefix2)">
	      <li><xsl:value-of select="."/></li>
	    </xsl:for-each>
	  </ul>
	</xsl:if>
	<xsl:if test="$prefix3 != ''">
	  <h3>P3:<xsl:value-of select="$prefix3"/></h3>
	  <ul>
	    <xsl:for-each select="key('prefix3',$prefix3)">
	      <li><xsl:value-of select="."/></li>
	    </xsl:for-each>
	  </ul>
	</xsl:if>
      </div>
    </li>
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

	    <xsl:choose>
	      <xsl:when test="substring-before($suffix,'.')">
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:apply-templates select="following-sibling::property[starts-with(name,$prefix_path)]" mode="filter">
		  <xsl:with-param name="prefix" select="$new_prefix_path"/>
		</xsl:apply-templates>
	      </xsl:otherwise>
	    </xsl:choose>

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
