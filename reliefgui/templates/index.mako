<%inherit file="master.mako" />

<%def name="content()">

<div id="header" class="ui-widget ui-corner-top ui-widget-content">
Position = ${c.position} unités (1 unité = ${c.resolution} pas du moteur)
</div>

<div id="tabs">
<ul>
<li><a href="#calibrate">Calibration</a><li>
<li><a href="#move">Déplacement</a><li>
<li><a href="#shoot">Prise de vue</a><li>
</ul>


<div id="calibrate">
  ${c.calibform|n}
</div>

<div id="move">
  ${c.moveform|n}
</div>

<div id="shoot">
  ${c.shootform|n}
</div>

</div>

<h2>Répétition</h2>
  <div class="widget">
    Répéter toute la séquence
    <input type="text" name="nb_repeat" size="4" /> fois
  </div>


</%def>
