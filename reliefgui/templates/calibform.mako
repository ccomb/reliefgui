## status message
% if len(c.calib)!=4:
    <div class="error-message">Veuillez terminer la calibration</div>
% endif

% if len(c.calib)!=0:
    ${h.form(url(controller='index', action='reset'), method='post')}
    <input type="submit" name="reset" value="Recommencer la calibration" class="ui-button" />
    ${h.end_form()}
    % if len(c.calib) > 0:
      <div class="ui-widget-header ui-corner-all">
        <h2>Valeurs enregistrées :</h2>
        % for name,value in sorted(c.calib.items()):
            <div>${name} = ${value}</div>
        % endfor
      </div>
    % endif
%endif

## first step
% if 'left' not in c.calib:
  <h3>Étape 1 : position gauche</h3>
  Déplacez-vous jusqu'à la position gauche avec l'onglet
  «&nbsp;Déplacement&nbsp;»,
  puis appuyez sur le bouton ci-dessous :<br/>
  ${h.form(url(controller='index', action='store_left'), method='post')}
  <div class="widget">
    <input type="submit" name="store_left" value="Enregistrer la position gauche" class="ui-button" />
  </div>
  ${h.end_form()}

## second step
% elif 'distance' not in c.calib:
  <h3>Étape 2 : position droite</h3>
  Déplacez-vous jusqu'à la position droite avec l'onglet
  «&nbsp;Déplacement&nbsp;», mesurez la distance parcourue,
  puis appuyez sur le bouton ci-dessous :<br/>
  ${h.form(url(controller='index', action='store_right'), method='post')}
  <div class="widget">
    Distance mesurée :
    <input type="text" name="maxrange" size="4" /> (mm, cm, degrés, etc.)
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
% endif


