  Déplacez-vous jusqu'à la position extrême droite avec l'onglet
  «&nbsp;Déplacement&nbsp;», mesurez la distance parcourue,
  puis appuyez sur le bouton ci-dessous :<br/>
  ${h.form(url(controller='index', action='store_right'), method='post')}
  <div class="widget">
    Distance mesurée :
    <input type="text" name="maxrange" size="4" />
  </div>
  <div class="widget">
    <input type="checkbox" name="limit">
    Interdire les déplacements au-delà des limites.
    </input>
  </div>
  <div class="widget">
    <input type="submit" value="Enregistrer la position droite" class="ui-button" />
  </div>
  ${h.end_form()}

