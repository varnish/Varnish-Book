<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:str="http://exslt.org/strings"
  extension-element-prefixes="str">

  <!--
  Copyright © 2007 Simon McVittie <http://smcv.pseudorandom.co.uk/>

  Copying and distribution of this file, with or without modification,
  are permitted in any medium without royalty provided the copyright
  notice and this notice are preserved.
  -->

  <xsl:output method="text" indent="no" encoding="ascii"/>

  <xsl:param name="name" select="'rst2html'"/>
  <xsl:param name="date" select="'October 2007'"/>
  <xsl:param name="source" select="'docutils'"/>
  <xsl:param name="section" select="'1'"/>
  <xsl:param name="section_name" select="'User Commands'"/>
  <xsl:param name="oneliner" select="'convert reST documents to HTML'"/>

  <xsl:variable name="upper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
  <xsl:variable name="lower" select="'abcdefghijklmnopqrstuvwxyz'"/>

  <xsl:template match="section[@names='usage']">
    <xsl:text>.SH SYNOPSIS&#10;</xsl:text>

    <xsl:text>.IP&#10;</xsl:text>
    <xsl:value-of select="block_quote/paragraph" />
    <xsl:text>&#10;</xsl:text>

    <xsl:text>.SH DESCRIPTION&#10;</xsl:text>
    <xsl:value-of select="paragraph" />
    <xsl:text>&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="option_string">
    <xsl:text>\fB</xsl:text>
    <xsl:value-of select="str:replace(., '-', '\-')"/>
    <xsl:text>\fR</xsl:text>
  </xsl:template>

  <xsl:template match="option">
    <xsl:apply-templates/>
    <xsl:if test="not(position() = last())">
      <xsl:text>, </xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="option_argument">
    <xsl:value-of select="@delimiter"/>
    <xsl:text>\fI</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>\fR</xsl:text>
  </xsl:template>

  <xsl:template match="option_list_item">
    <xsl:text>.TP&#10;</xsl:text>
    <xsl:apply-templates select="option_group"/>
    <xsl:text>&#10;</xsl:text>
    <xsl:apply-templates select="description"/>
    <xsl:text>&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="section[@names='options']/section">
    <xsl:text>&#10;.SS&#10;\fB</xsl:text>
    <xsl:value-of select="title"/>
    <xsl:text>\fR&#10;</xsl:text>
    <xsl:apply-templates select="option_list"/>
  </xsl:template>

  <xsl:template match="section[@names='options']">
    <xsl:text>.SH OPTIONS&#10;</xsl:text>
    <xsl:apply-templates select="section"/>
  </xsl:template>

  <xsl:template match="/">
    <xsl:text>.TH </xsl:text>
    <xsl:value-of select="translate($name, $lower, $upper)"/>
    <xsl:text> "</xsl:text>
    <xsl:value-of select="$section"/>
    <xsl:text>" "</xsl:text>
    <xsl:value-of select="$date"/>
    <xsl:text>" "</xsl:text>
    <xsl:value-of select="$source"/>
    <xsl:text>" "</xsl:text>
    <xsl:value-of select="$section_name"/>
    <xsl:text>"&#10;</xsl:text>
    <xsl:text>.SH NAME&#10;</xsl:text>
    <xsl:value-of select="$name"/>
    <xsl:text> \- </xsl:text>
    <xsl:value-of select="$oneliner"/>
    <xsl:text>&#10;</xsl:text>
    <xsl:apply-templates select="/document/section[@names='usage']"/>
    <xsl:apply-templates select="/document/section[@names='options']"/>
    <xsl:text>.SH AUTHOR&#10;</xsl:text>
    <xsl:text>This man page was generated from the \-\-help output </xsl:text>
    <xsl:text>of the tool it documents, using a script written by </xsl:text>
    <xsl:text>Simon McVittie for the Debian GNU/Linux system. </xsl:text>
    <xsl:text>The script may be used by others: please see the </xsl:text>
    <xsl:text>Debian source package if you're interested.</xsl:text>
  </xsl:template>

</xsl:stylesheet>

<!-- vim:set sw=2 sts=2 et noai noci: -->
