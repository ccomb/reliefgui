  ${h.form(url(controller='index', action='shoot'), method='post')}
    <div class="widget">
      Distance entre 2 photos (base) :
      <input type="text" name="base" size="4" /> ${c.calib.get('unit', u'pas')}
    </div>
    <div class="widget">
      Nombre de prises de vue :
      <input type="text" name="nb_points" size="4" />
    </div>
    <div class="widget">
      Mode :<br/>
      <input type="radio" name="mode" value="manual">Manuel</input><br/>
      <input type="radio" name="mode" value="slow">Automatique</input><br/>
      <!-- <input type="radio" name="mode" value="burst">Rafale</input> -->
    </div>
  <div class="widget">
    <input type="submit" value="Démarrer" class="ui-button" />
  </div>
  ${h.end_form()}

