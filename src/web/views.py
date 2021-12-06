from django.shortcuts import render, HttpResponse, redirect
from .models import Person
from .forms import LoginForm
from django.db import connection

def home(request):
    if request.session.has_key('usr_id'):
        return render(request, 'home.html', {'name':request.session['usr_id'][0]})
    else:
       return redirect(login)

def login(request):
    email = 'none'
    if request.method == 'POST':
        newLogin = LoginForm(request.POST)
        if newLogin.is_valid():
            request.session['usr_id'] = newLogin.getUserId()
            return redirect(home)
        else:
            return render(request, "login.html", {'invalid': newLogin.errors.popitem()[1][0]})
    return render(request, "login.html")

def logout(request):
    if request.session.has_key('usr_id'):
        del request.session['usr_id']
    return redirect(login)

def detailed(request):
    if request.session.has_key('usr_id'):
        people = {}
        with connection.cursor() as cursor:
            cursor.execute("select * from person order by person_id")
            rows = cursor.fetchall()
            for row in rows:
                temp_l = []
                for col in row[1:]:
                     temp_l.append(col)
                people[row[0]] = temp_l
        return render(request, 'detailed.html', {'people': people})
    else:
        return redirect(login)