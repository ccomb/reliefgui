<%inherit file="master.mako" />

<%def name="content()">

<div id="header" class="ui-widget ui-corner-top ui-widget-content">
<span id="position">Position = ${c.position} ${c.calib.get('unit', u'pas (moteur)')}</span>
%if 'unit' in c.calib:
 (1 ${c.calib['unit']} = ${c.resolution} pas du moteur)
%endif
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


</%def>
