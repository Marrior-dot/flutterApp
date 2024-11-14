"""
ASGI config for myapi project.

It exposes the ASGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/5.0/howto/deployment/asgi/
"""
import os
from channels.auth import AuthMiddlewareStack
from channels.routing import ProtocolTypeRouter, URLRouter
from channels.security.websocket import AllowedHostsOriginValidator
from django.core.asgi import get_asgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'myapi.settings')
django_asgi_app = get_asgi_application()

import myapp.socket.routing

application = ProtocolTypeRouter({
    'http':django_asgi_app, 
    "websocket": AllowedHostsOriginValidator(
            AuthMiddlewareStack(
                URLRouter(myapp.socket.routing.websocket_urlpatterns))
        )
})