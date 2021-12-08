from django.urls import path

from . import views

urlpatterns = [
    path('', views.home, name='index'),
    path('login', views.login, name="login"),
    path('logout', views.logout, name='logout'),
    path('detailed', views.detailed, name='detailed'),
    path('noPermission', views.noPermission, name='noPermission'),
    path('<int:person_id>/editEntity', views.editEntity, name='editEntity')
]