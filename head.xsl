<?xml version="1.0"?>
<!--
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License. See accompanying LICENSE file.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html"/>
  <xsl:template match="configuration" mode="head">
    <head>
      <meta charset="utf-8"></meta>
      <title>Apache Hadoop Configuration Properties</title>
      <meta name="viewport" content="width=device-width, initial-scale=1.0"></meta>
      <meta name="description" content=""></meta>
      <meta name="author" content=""></meta>
      
      <!-- Le styles -->
      <link href="http://twitter.github.com/bootstrap/assets/css/bootstrap.css" rel="stylesheet">
      </link>
      <style>
	body {
	padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
	}
      </style>
      <link href="http://twitter.github.com/bootstrap/assets/css/bootstrap-responsive.css" rel="stylesheet"></link>
      
      <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
      <!--[if lt IE 9]>
	  <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
	  <![endif]-->
      
      <style>
	table.decomposed {
	  width:50%;
	}
	table.decomposed td {
	  width:10em;
	}
	th {
  	  text-align:right;
	}
	td.value {
	  white-space:nowrap;
	}
	
	td.value div {
	  font-family:monospace;
	  width:20em;
	  overflow:hidden;
	}
	
	td.value div:hover {
	  z-index:3;
	  opacity:1;
	  background:white;
	  text-overflow:inherit;
	  overflow:visible;
	}
	
	td.description {
	  z-index:0;
	  text-align:right;
	  line-height:1.35em;
	}
	
	div.properties {
	  z-axis:1;
	  margin-left:1em;
	  float:left;
	  width:100%;
	}
	
	div.colophon {
	  z-axis:0;
	  right:10%;
	  position:fixed;
	  top:0;
	  padding:0.25em;
	  margin:0.5em;
	  background:#eee;
	  border:1px solid darkgrey;
	  border-radius:15px;
	  -moz-border-radius:15px;
	  float:left;width:25%;
	}
	div.colophon ul {
	  margin:0;
	  padding:.25em;
	  padding-left:1.75em;
	}
	
      </style>
      
    </head>
    
  </xsl:template>
</xsl:stylesheet>
