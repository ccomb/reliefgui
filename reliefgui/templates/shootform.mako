${h.form(url(controller='index', action='index'), method='post')}
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
