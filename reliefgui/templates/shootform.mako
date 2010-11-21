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
      <input type="radio" name="mode" value="slow">arrêt à chaque photo</input><br/>
      <input type="radio" name="mode" value="burst">photos en rafale</input><br/>
    </div>
    <div id="imps">
      Vitesse de la rafale : <input type="text" name="imps" size="4"/> im/s
    </div>

    <div>
        <input type="checkbox" name="auto" value="True">
            Déclencher l'appareil photo automatiquement.
        </input>
    </div>
  <div class="widget">
    <input type="submit" value="Démarrer" class="ui-button" />
  </div>
  ${h.end_form()}

<script type="text/javascript">
update_imps = function() {
    // update the images/s input display
    if ($('input[name=mode]:checked').val() == 'burst') {
        $('#imps').show('fast')
    } else {
        $('#imps').hide()
    }
}
$('input[name=mode]:radio').change(update_imps)
update_imps()
</script>
