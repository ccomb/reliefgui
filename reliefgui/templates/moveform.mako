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
      Se déplacer 
      <select name="direction">
        <option value="=">vers la position exacte</option>
        <option value="-">vers la gauche de</option>
        <option value="+">vers la droite de</option>
      </select>
      <input type="text" name="move" size="6" /> ${c.calib.get('unit', u'pas')}
    </span>
    </div>
    <div class="widget">
      à la vitesse de 
      <input type="text" name="speed" size="5" /> ${c.calib.get('unit', u'pas')}/s,
      ou pendant
      <input type="text" name="duration" size="4" /> secondes
    </div>
  <div class="widget">
    <input type="submit" value="Démarrer" class="ui-button" />
  </div>
  ${h.end_form()}

