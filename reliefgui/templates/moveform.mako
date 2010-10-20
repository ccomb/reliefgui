  ${h.form(url(controller='index', action='fast_move'), method='post')}
    <div style="text-align: center">
    <h2>Positionnement rapide</h2>
    <p>Attention les déplacements de ces boutons est en nombre de pas moteur.</p>
   ←<input type="submit" name="fastmove" value="-1000" />
    <input type="submit" name="fastmove" value="-100" />
    <input type="submit" name="fastmove" value="-10" />
    <input type="submit" name="fastmove" value="-1" /> O
    <input type="submit" name="fastmove" value="+1" />
    <input type="submit" name="fastmove" value="+10" />
    <input type="submit" name="fastmove" value="+100" />
    <input type="submit" name="fastmove" value="+1000" />→
    </div>
  ${h.end_form()}

    <h2>Déplacement</h2>
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
      Position :
      <input type="text" name="move" size="6" /> unités
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

