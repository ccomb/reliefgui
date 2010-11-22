  ${h.form(url(controller='index', action='shoot'), method='post')}
    <div class="widget">
      Distance entre 2 photos (base) :
      <input type="text" name="base" size="3" /> ${c.calib.get('unit', u'pas')}
    </div>
    <div class="widget">
        Nombre de prises de vue :
        <input type="text" name="nb_points" size="3" />
        <div id="fast_previews_block" style="text-align: center">
            <h4 id="fast_preview_title">Déplacement rapide vers chaque photo</h4>
            <div id="fast_previews" style="text-align: center">
            </div>
        </div>

    </div>
    <div class="widget">
      Mode :
      <div>
      <input type="radio" name="mode" value="slow">arrêt à chaque photo</input>
        <div id="wait_time">Temp d'attente entre photos : <input type="text" name="wait_time" size="3"/> s</div>
      </div>
      <div>
      <input type="radio" name="mode" value="burst">photos en rafale</input>
        <div id="imps">Vitesse de la rafale : <input type="text" name="imps" size="3"/> im/s</div>
        </div>
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
        $('#wait_time').hide('fast')
        $('#imps').hide('fast')
    if ($('input[name=mode]:checked').val() == 'burst') {
        $('#imps').show('fast')
    }
    if ($('input[name=mode]:checked').val() == 'slow') {
        $('#wait_time').show('fast')
    }
}
update_previews = function() {
    nb_points = $(':input[name=nb_points]').val();
    base = $(':input[name=base]').val();
    if (nb_points > 1) {
        $('#fast_previews_block').show('fast');
        $('#fast_previews').empty()
        $('#fast_previews').append('<input type="submit" name="fast_preview" value="0" /><br/>')
        for (i=1; (i<=nb_points && i<500); i++) {
            $('#fast_previews').append('<input type="submit" name="fast_preview" value="' + i + '" />')
        }
    } else { $('#fast_previews_block').hide('fast'); }
}
$('input[name=mode]:radio').change(update_imps)
$('input[name=nb_points]:input').keyup(update_previews)
update_imps()
update_previews()
</script>
