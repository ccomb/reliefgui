<%inherit file="master.mako" />

<%def name="content()">

<div id="header" class="ui-widget ui-corner-top ui-widget-content">
Position = ${c.position} | Resolution = ${c.resolution}
</div>

<div id="tabs">
<ul>
<li><a href="#calibrate">Calibration</a><li>
<li><a href="#move">Déplacement</a><li>
<li><a href="#shoot">Prise de vue</a><li>
</ul>


<div id="calibrate">

% if len(c.calib)!=4:
    <div class="error-message">Veuillez terminer la calibration</div>
% endif

Valeurs actuelles :<br/>
% for name,value in sorted(c.calib.items()):
    <div>${name} = ${value}</div>
% endfor

  <h3>Étape 1 : position gauche</h3>
  ${c.leftcalibform|n}

  <h3>Étape 2 : position droite</h3>
  ${c.rightcalibform|n}

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
