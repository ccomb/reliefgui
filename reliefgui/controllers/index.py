import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect_to
from pylons.decorators import validate

from reliefgui.lib.base import BaseController, render
from reliefcnc.shoot import ReliefShooter
import formencode

log = logging.getLogger(__name__)

class ShootForm(formencode.Schema):
    base = formencode.validators.Int(not_empty=True)
    mode = formencode.validators.OneOf(['slow', 'burst'])

class IndexController(BaseController):

    def index(self):
        # Return a rendered template
        #return render('/index.mako')
        # or, return a response
        return render('index.pt')

    def form(self):
        return render('form.mako')

    @validate(schema=ShootForm(), form='index')
    def capture(self):
        base = self.form_result['base']
        mode = self.form_result['mode']

        shooter = ReliefShooter()
        shooter.resolution = 100.0/3
        shooter.maxrange = 360
        shooter.nb_points = 3
        shooter.base = base
        if mode == 'slow':
            shooter.slow()
        elif mode == 'burst':
            shooter.burst()

        shooter.off()
        del shooter


        redirect_to(action='index')


