  ${h.form(url(controller='index', action='move'), method='post')}
    <div class="widget">
    <span class="widget">
      Sens du déplacement :
      <select name="direction">
        <option value="=">absolu</option>
        <option value="+">positif</option>
        <option value="-">négatif</option>
      </select>
    <div class="widget">
      Déplacement :
      <input type="text" name="move" size="6" />
    </div>
    </span>
    </div>
    <div class="widget">
      vitesse :
      <input type="text" name="speed" size="5" /> unités/s
    </div>
      ou
    <div class="widget">
      durée :
      <input type="text" name="duration" size="4" /> secondes
    </div>
  <div class="widget">
    <input type="submit" value="Démarrer" class="ui-button" />
  </div>
  ${h.end_form()}

