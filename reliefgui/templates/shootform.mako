${h.form(url(controller='index', action='index'), method='post')}
  <div class="form">
    Nombre de points de vue :
    <input type="text" name="nb_points" size="4" />
  </div>
  <div class="form">
    Base :
    <input type="text" name="base" size="4" /> mm
  </div>
  <div class="form">
    Mode :<br/>
    <input type="radio" name="mode" value="manual">Manuel</input><br/>
    <input type="radio" name="mode" value="slow">Automatique</input><br/>
    <input type="radio" name="mode" value="burst">Rafale</input>
  </div>
  <div class="form">
    <input type="submit" value="Capture" />
  </div>
${h.end_form()}
