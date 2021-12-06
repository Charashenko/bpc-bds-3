from django.shortcuts import render, HttpResponse, redirect
from .models import Person, PersonHasRole, Role
from .forms import LoginForm
from django.db import connection

def home(request):
    if request.session.has_key('usr_id'):
        return render(request, 'home.html', {'name':request.session['usr_id'][1]})
    else:
       return redirect(login)

def login(request):
    email = 'none'
    if request.method == 'POST':
        newLogin = LoginForm(request.POST)
        if newLogin.is_valid():
            request.session['usr_id'] = newLogin.getUserId()
            print(newLogin.getUserId())
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
        if request.method == 'POST':
            people = {}
            usr_guery = request.POST.get('query')
            with connection.cursor() as cursor:
                cursor.execute("select * from person")
                rows = cursor.fetchall()
                for row in rows:
                    temp_l = []
                    for col in row[1:]:
                        temp_l.append(col)
                    people[row[0]] = temp_l
            return render(request, 'detailed.html', {'people': people})
        else:
            return render(request, 'detailed.html')
    else:
        return redirect(login)