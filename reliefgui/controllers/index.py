import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect_to
from pylons.decorators import validate

from reliefgui.lib.base import BaseController, render
from reliefcnc.shoot import RailShooter, TournetteShooter
from formencode import htmlfill, Schema, validators

log = logging.getLogger(__name__)

class RailForm(Schema):
    nb_points = validators.Int(not_empty=True)
    base = validators.Int(not_empty=True)
    mode = validators.OneOf(['slow', 'burst', 'manual'])


class TournetteForm(Schema):
    nb_points = validators.Int(not_empty=True)
    base = validators.Int(not_empty=True)
    mode = validators.OneOf(['slow', 'burst', 'manual'])


class IndexController(BaseController):

    def index(self):
        return render('index.mako')

    def tournette(self):
        errors = None
        form_result = None
        if request.POST:
            schema = TournetteForm()
            try:
                form_result = schema.to_python(request.POST)
            except validators.Invalid, error:
                errors = error.unpack_errors()
            else:
                nb_points = form_result['nb_points']
                base = form_result['base']
                mode = form_result['mode']

                shooter = TournetteShooter()
                shooter.resolution = 26.7
                shooter.maxrange = 360
                shooter.nb_points = nb_points
                shooter.base = base
                if mode == 'slow':
                    shooter.slow()
                elif mode == 'burst':
                    shooter.burst()
                elif mode == 'manual':
                    shooter.manual()
                shooter.off()
                del shooter

        c.form = htmlfill.render(render('/tournetteform.mako'),
                                         defaults=request.POST,
                                         errors=errors)

        return render('tournette.mako')

    def rail(self):
        errors = None
        form_result = None
        if request.POST:
            schema = RailForm()
            try:
                form_result = schema.to_python(request.POST)
            except validators.Invalid, error:
                errors = error.unpack_errors()
            else:
                nb_points = form_result['nb_points']
                base = form_result['base']
                mode = form_result['mode']

                shooter = RailShooter()
                shooter.resolution = 26.7
                shooter.maxrange = 360
                shooter.nb_points = nb_points
                shooter.base = base
                if mode == 'slow':
                    shooter.slow()
                elif mode == 'burst':
                    shooter.burst()
                elif mode == 'manual':
                    shooter.manual()
                shooter.off()
                del shooter

        c.form = htmlfill.render(render('/railform.mako'),
                                         defaults=request.POST,
                                         errors=errors)

        return render('rail.mako')

