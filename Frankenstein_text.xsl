<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    
    <!-- <xsl:output method="xml" omit-xml-declaration="yes" indent="yes" /> -->
    <xsl:template match="tei:teiHeader"/>

    <xsl:template match="tei:body">
        <div class="row">
        <div class="col-3"><br/><br/><br/><br/><br/>
            <xsl:for-each select="//tei:add[@place = 'marginleft']">
                <xsl:choose>
                    <xsl:when test="parent::tei:del">
                        <del>
                            <xsl:attribute name="class">
                                <xsl:value-of select="attribute::hand" />
                            </xsl:attribute>
                            <xsl:value-of select="."/></del><br/>
                    </xsl:when>
                    <xsl:otherwise>
                        <span >
                            <xsl:attribute name="class">
                                <xsl:value-of select="attribute::hand" />
                            </xsl:attribute>
                        <xsl:value-of select="."/><br/>
                        </span>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each> 
        </div>
        <div class="col-9">
            <div class="transcription">
                <xsl:apply-templates select="//tei:div"/>
            </div>
        </div>
        </div> 
    </xsl:template>
    
  
  <xsl:template match="tei:head">
    <div style="font-size: 16px; margin-left: 60px; margin-top: 20px; margin-bottom: 5px;">
        <!-- Text before 'th' -->
        <xsl:value-of select="substring-before(., 'th')"/>
        
        <!-- Superscript 'th' -->
        <sup>
            <!-- Extract only 'th' and ignore other content -->
            <xsl:if test="contains(., 'th')">th</xsl:if>
        </sup>
    </div>
</xsl:template>

<xsl:template match="tei:metamark[@function='pagenumber']">
    <div class="pagenumber" style="display: flex; justify-content: flex-end; margin-top: 0px; margin-right: 40px;">
        <!-- Iterate through all num elements for page numbers -->
        <xsl:for-each select="tei:num">
            <span>
                <xsl:attribute name="style">
                    <xsl:text>display: inline-block; </xsl:text>
                    <!-- Apply margin-left from the XML attribute -->
                    <xsl:if test="@margin-left">
                        <xsl:text>margin-left: </xsl:text>
                        <xsl:value-of select="@margin-left"/>
                        <xsl:if test="not(contains(@margin-left, 'px') or contains(@margin-left, 'em') or contains(@margin-left, '%'))">
                            <xsl:text>px</xsl:text>
                        </xsl:if>
                        <xsl:text>;</xsl:text>
                    </xsl:if>
                </xsl:attribute>
                <!-- Output the value of the number -->
                <xsl:value-of select="."/>
            </span>
        </xsl:for-each>
    </div>
</xsl:template>

   <!-- Line break -->
<xsl:template match="tei:lb">
        <br/>
</xsl:template>


<xsl:template match="tei:del[@type='crossedOut']">
  <xsl:choose>
        <xsl:when test="@style = 'no-italic'">
           <span class="crossed-out-{@hand}" 
            style="position: relative; color: gray; text-decoration: line-through;">
        <xsl:apply-templates/>
      </span>
    </xsl:when>
    
       <xsl:otherwise>
      <span class="crossed-out-{@hand}" 
            style="position: relative; color: gray; text-decoration: line-through; font-size: 15px; font-style: italic;">
        <xsl:apply-templates/>
      </span>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>



<xsl:template match="tei:add[@place='supralinear']">
    <span style="position: relative; margin-left: -270px; top: -1.6em; color: inherit;">
        <xsl:apply-templates/>
    </span>
</xsl:template>

<xsl:template match="tei:add[@place='supralinear' and not(@type='italicized')]">
  <span style="position: relative; margin-left: -170px; top: -1.6em; color: inherit;padding-right: 47px;">
    <xsl:apply-templates/>
  </span>
</xsl:template> 

 <!-- <xsl:template match="tei:add[@place='supralinear' and @type='italic-smallmargin']">
  <span style="position: relative;font-size: 14px; margin-left:-55px; top:-1.5em; font-style: italic; color: inherit;padding-right: -14px;">
    <xsl:apply-templates/>
  </span>
</xsl:template>  -->



<!-- <xsl:template match="tei:add[@place='supralinear' and @type='italic-smallmargin']">
  <span style="position: relative; display: inline-block; vertical-align: middle; line-height: 1;">
    <span style="position: absolute; top: -1.4em; left: 50%; transform: translateX(-50%); font-size: 14px; font-style: italic; color: inherit;">
      <xsl:apply-templates/>
    </span>
    <span style="visibility: hidden; display: inline-block; width: 0; height: 0;">A</span>
  </span>
</xsl:template> -->
<xsl:template match="tei:add[@place='supralinear' and @type='italic-smallmargin']">
  <span style="position: relative; display: inline; vertical-align: middle; line-height: 4;">
    <span style="position: absolute; top: -3em; left: 50%; transform: translateX(-30%); margin-left:-17px; white-space: nowrap; font-size: 14px; font-style: italic; color: inherit;padding-right: 0em;">
      <xsl:apply-templates/>
    </span>
  </span>
</xsl:template>

 <xsl:template match="tei:add[@place='supralinear' and @type='italic-ssmallmargin']">
  <span style="position: absolute; font-size: 14px; margin-left: -34px; 
     top:19em; font-style: italic;padding-right:0px; color: inherit;">
    <xsl:apply-templates/>
  </span>
</xsl:template>

<xsl:template match="tei:add[@place='supralinear' and @type='italic-largmargin']">
  <span style="position: relative;font-size: 14px; margin-left:-70px; top:-1.5em; font-style: italic; color: inherit; padding-right: -10px;">
    <xsl:apply-templates/>
  </span>
</xsl:template> 

<xsl:template match="tei:add[@place='supralinear' and @type='liftup']">
  <span style="position: relative;font-size: 14px;margin-left:-4px; top:1em;  color: inherit;padding-right:0px;">
    <xsl:apply-templates/>
  </span>
</xsl:template> 


<xsl:template match="tei:add[@place='supralinear' and @type='liftup2']">
  <span style="position: relative;font-size: 14px;margin-left:0px; top:.5em;  color: inherit;padding-right:0px;">
    <xsl:apply-templates/>
  </span>
</xsl:template> 


<xsl:template match="tei:add[@place='supralinear' and @type='exact']">
  <span style="position: relative;font-size: 14px;margin-left:-10px; top:-1em;  color: inherit;padding-right:0px;font-style: italic;">
    <xsl:apply-templates/>
  </span>
</xsl:template> 


<xsl:template match="tei:del[@type='overwritten']">
  <xsl:choose>
    <!-- Check if rend attribute contains 'blackink' -->
    <xsl:when test="contains(@rend, 'blackink')">
      <!-- Apply black color and no strikethrough (text-decoration: none) -->
      <span style="color: black; text-decoration: none;" class="{@hand}">
        <xsl:apply-templates/>
      </span>
    </xsl:when>
    
    <!-- Default behavior with gray color and line-through -->
    <xsl:otherwise>
      <span style="color: gray; text-decoration: line-through;" class="{@hand}">
        <xsl:apply-templates/>
      </span>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="tei:add[@type='overwritten']">
  <span style="color: black; text-decoration: none; font-style: italic;" class="{@hand}">
    <xsl:apply-templates/>
  </span>
</xsl:template>

<xsl:template match="tei:add[@place='marginleft']">
  <span class="marginAdd"
        style="display: block;
               position: absolute;
               left: -150px;
               top: {@vertical-position}px; 
               width: 150px;
               font-style: italic;">
    <xsl:apply-templates select="node()" />
  </span>
</xsl:template>

<xsl:template match="tei:hi">
  <i>
    <xsl:apply-templates select="node()" />
  </i>
</xsl:template>







<xsl:template match="add[@place='supralinear' and @type='caret']">
  <span style="font-size: 12px; margin-right:0px; position: relative; top: -2px; color: inherit;">
    <xsl:apply-templates/>
  </span>
</xsl:template>

<xsl:template match="add[@place='inline']">
    <span style="font-style: italic;">
        <xsl:apply-templates/>
    </span>
</xsl:template>



    <xsl:template match="tei:div">
        <div class="#MWS"><xsl:apply-templates/></div>
    </xsl:template>
    
    <xsl:template match="tei:p">
        <p><xsl:apply-templates/></p>
    </xsl:template>

  

<xsl:template match="tei:hi">
  <i>
    <xsl:apply-templates select="node()" />
  </i>
</xsl:template>



<xsl:template match="tei:l[@rend='indent']">
  <p style="text-indent: 30px;">
    <xsl:apply-templates select="node()" />
  </p>
</xsl:template>











</xsl:stylesheet>
