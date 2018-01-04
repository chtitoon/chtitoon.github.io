<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:str="http://exslt.org/strings"
                extension-element-prefixes="str">

<xsl:import href="str/str.xsl" />
<xsl:template match="/">
  <html>
  <title>Hello</title>
  <body>
    <h1>List of top rated songs</h1>
    <ul>
      <xsl:for-each select="plist/dict/dict/dict">
        <xsl:sort select="key[text()='Play Count']/following-sibling::node()" data-type="number" order="descending"/>
        <li class="post-album-item">
          <div class="post-album-wrapper">
              <xsl:variable name="album-name" select="key[text()='Album']/following-sibling::node()" />
              <xsl:variable name="album-artist" select="key[text()='Artist']/following-sibling::node()" />
              <xsl:variable name="song" select="key[text()='Name']/following-sibling::node()" />
              <xsl:variable name="album-name-encoded" select="str:replace(str:encode-uri($album-name, true()), '?','%3F')"/>
              <xsl:variable name="album-artist-encoded" select="str:encode-uri($album-artist, true())"/>
              <xsl:variable name="album-song-encoded" select="str:encode-uri($song, true())"/>
              <img class="post-album-art" src="/assets/img/albums/{$album-artist-encoded} - {$album-name-encoded}.jpg"></img>
              <a href="http://www.youtube.com/results?search_query={$album-song-encoded}%20{$album-artist-encoded}" target="_blank" class="post-album-title"><xsl:value-of select="$song"/></a>
              <span class="post-album-name"><xsl:value-of select="$album-name"/></span>
              <span class="post-album-artist"><xsl:value-of select="$album-artist" /></span>
          </div>
        </li>
      </xsl:for-each>
    </ul>
  </body>
  </html>
</xsl:template>

</xsl:stylesheet>