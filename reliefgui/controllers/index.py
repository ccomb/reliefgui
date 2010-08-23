import os
from ConfigParser import SafeConfigParser
from formencode import htmlfill, Schema, validators, api
from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect_to
from pylons.decorators import validate
from reliefcnc.shoot import ReliefShooter
from reliefgui.lib.base import BaseController, render
from webob.exc import HTTPFound
import logging

log = logging.getLogger(__name__)

class RightCalibSchema(Schema):
    maxrange = validators.Number()
    limit = validators.Bool()


class SpeedOrDuration(validators.FormValidator):
    def validate_python(self, values, state):
        if values['speed'] and values['duration']:
            message = u"Il faut choisir entre vitesse et duree"
            raise api.Invalid(message, None, None)
        return values


class MoveSchema(Schema):
    direction = validators.OneOf(['=', '+', '-'])
    move = validators.Number(not_empty=True)
    speed = validators.Number()
    duration = validators.Number()
    chained_validators = [ SpeedOrDuration() ]


class ShootSchema(Schema):
    nb_points = validators.Int(not_empty=True)
    base = validators.Int(not_empty=True)
    mode = validators.OneOf(['slow', 'burst', 'manual'])


class IndexController(BaseController):

    def _calib(self, **kw):
        # read or write saved calibration
        calib_filename = "saved.cfg"
        if 'restart' in kw:
            os.remove(calib_filename)
            kw.pop('restart')
        section = 'calibration'
        conf = SafeConfigParser()
        try:
            calib_file = open(calib_filename, 'r+')
            conf.readfp(calib_file)
        except:
            calib_file = open(calib_filename, 'w')
            conf.add_section(section)
        if not len(kw):
            return dict(conf.items(section))
        else:
            for v in kw.keys():
                if kw[v] is not None:
                    conf.set(section, v, str(kw[v]))
            calib_file.seek(0)
            conf.write(calib_file)
            calib_file.close()
            return kw

    def index(self):
        """Home page with several forms in tabs
        """
        c.calib = calib = self._calib()
        shooter = ReliefShooter()
        if 'steps' in calib and 'distance' in calib and 'limit' in calib:
            shooter.calibrate(steps=calib['steps'],
                              distance=calib['distance'],
                              limit=bool(calib['limit']))
        c.position = shooter.cnc.x / shooter.resolution
        c.resolution = shooter.resolution
        errors = request.environ['beaker.session'].get('leftcaliberrors', {})
        values = request.environ['beaker.session'].get('leftcalibvalues', {})
        request.environ['beaker.session']['leftcaliberrors'] = None
        request.environ['beaker.session']['leftcalibvalues'] = None
        c.leftcalibform = htmlfill.render(render('/leftcalibform.mako'),
                                         defaults=values,
                                         errors=errors)
        errors = request.environ['beaker.session'].get('rightcaliberrors', {})
        values = request.environ['beaker.session'].get('rightcalibvalues', {})
        request.environ['beaker.session']['rightcaliberrors'] = None
        request.environ['beaker.session']['rightcalibvalues'] = None
        c.rightcalibform = htmlfill.render(render('/rightcalibform.mako'),
                                         defaults=values,
                                         errors=errors)
        errors = request.environ['beaker.session'].get('moveerrors', {})
        values = request.environ['beaker.session'].get('movevalues', {})
        request.environ['beaker.session']['moveerrors'] = None
        request.environ['beaker.session']['movevalues'] = None
        c.moveform = htmlfill.render(render('/moveform.mako'),
                                         defaults=values,
                                         errors=errors)
        errors = request.environ['beaker.session'].get('shooterrors', {})
        values = request.environ['beaker.session'].get('shootvalues', {})
        request.environ['beaker.session']['shooterrors'] = None
        request.environ['beaker.session']['shootvalues'] = None
        c.shootform = htmlfill.render(render('/shootform.mako'),
                                         defaults=values,
                                         errors=errors)
        request.environ['beaker.session'].save()
        return render('index.mako')


    def store_left(self):
        if 'store_left' in request.POST:
            shooter = ReliefShooter()
            self._calib(left=shooter.cnc.x, restart=True)
        return HTTPFound(location="/#calibrate")

    def store_right(self):
        errors = form_result = None
        try:
            form_result = RightCalibSchema.to_python(request.POST)
        except validators.Invalid, error:
            errors = error.unpack_errors()
        request.environ['beaker.session']['rightcaliberrors'] = errors
        request.environ['beaker.session']['rightcalibvalues'] = request.POST
        request.environ['beaker.session'].save()
        if errors is not None:
            return HTTPFound(location="/")
        shooter = ReliefShooter()
        steps = shooter.cnc.x
        maxrange = form_result['maxrange']
        limit = form_result['limit']
        left = int(self._calib()['left'])
        self._calib(steps=steps-left, distance=maxrange, limit=limit)
        return HTTPFound(location="/")

    def move(self):
        calib = self._calib()

        errors = form_result = None
        try:
            form_result = MoveSchema.to_python(request.POST)
        except validators.Invalid, error:
            errors = error.unpack_errors()
        request.environ['beaker.session']['moveerrors'] = errors
        request.environ['beaker.session']['movevalues'] = request.POST
        request.environ['beaker.session'].save()
        if errors is not None:
            return HTTPFound(location="/#move")
        shooter = ReliefShooter()
        # calibrate if we can
        if 'steps' in calib and 'distance' in calib and 'limit' in calib:
            shooter.calibrate(steps=calib['steps'],
                              distance=calib['distance'],
                              limit=calib['limit']=='True')
        direction = form_result['direction']
        move = form_result['move']
        speed = form_result['speed']
        duration = form_result['duration']
        try:
            if direction in ('+', '-'):
                move = move if direction == '+' else -move
                shooter.move_by(move, speed=speed, duration=duration, ramp=0)
            else:
                shooter.move_to(move, speed=speed, duration=duration, ramp=0)
        except ValueError, error:
            request.environ['beaker.session']['moveerrors'] = str(error)
            request.environ['beaker.session'].save()
        return HTTPFound(location="/#move")

    def shoot(self):
        errors = form_result = None
        try:
            form_result = ShootSchema.to_python(request.POST)
        except validators.Invalid, error:
            errors = error.unpack_errors()
        if errors is not None:
            request.environ['beaker.session']['shooterrors'] = errors
            request.environ['beaker.session']['shootvalues'] = request.POST
            request.environ['beaker.session'].save()
            return HTTPFound(location="/#shoot")

        nb_points = form_result['nb_points']
        base = form_result['base']
        mode = form_result['mode']

        shooter = ReliefShooter()
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

        return HTTPFound(location="/#shoot")

