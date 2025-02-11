"""
ASGI config for myapi project.

It exposes the ASGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/5.0/howto/deployment/asgi/
"""

from django.core.asgi import get_asgi_application
django_asgi_app = get_asgi_application()

import os
from channels.auth import AuthMiddlewareStack
from channels.routing import ProtocolTypeRouter, URLRouter
from channels.security.websocket import AllowedHostsOriginValidator

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'myapi.settings')

# Importe as rotas do websocket
import myapp.socket.routing

application = ProtocolTypeRouter({
    #Requisições http
    'http':django_asgi_app,
    #Requisições websocket
    "websocket": 
            AuthMiddlewareStack(
                URLRouter(myapp.socket.routing.websocket_urlpatterns))
})