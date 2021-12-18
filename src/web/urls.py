from django.urls import path

from . import views

urlpatterns = [
    path('', views.home, name='home'),
    path('login', views.login, name="login"),
    path('logout', views.logout, name='logout'),
    path('detailed', views.detailed, name='detailed'),
    path('<int:person_id>/editEntity', views.editEntity, name='editEntity'),
    path('createEntity', views.createEntity, name='createEntity')
]