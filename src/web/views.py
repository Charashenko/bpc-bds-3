from django.shortcuts import render, HttpResponse, redirect
from .models import *
from .forms import LoginForm
from django.contrib import messages
from .utils import *

def home(request):
    check = sessionCheck(request)
    if check[0]:
        usr_info = request.session['usr_info']
        person = Person.objects.get(person_id=usr_info[0])

        attributes = getPersonAttrs(person)
        
        if request.method == 'GET': # TODO Choose site format
            if check[1]:
                print('admin')
            else:
                print('not admin')

            return render(request, 'home.html', attributes)
        elif request.POST.get('elementChange'):
            return redirect(elementChange)

        return render(request, 'home.html', attributes) 
    else:
       return redirect(login)

def login(request):
    email = 'none'
    if request.method == 'POST':
        newLogin = LoginForm(request.POST)
        if newLogin.is_valid():
            request.session['usr_info'] = newLogin.getUserInfo()
            return redirect(home)
        else:
            return render(request, "login.html", {'invalid': newLogin.errors.popitem()[1][0]})
    return render(request, "login.html")

def logout(request):
    if sessionCheck(request)[0]:
        del request.session['usr_info']
    return redirect(login)

def detailed(request):
    check = sessionCheck(request)
    if check[0]:
        if check[1]:
            people = []
            if request.method == 'POST':
                usr_guery = request.POST.get('query')
                qSet = Person.objects.filter(name__icontains=usr_guery).all().order_by('person_id')

            else:
                qSet = Person.objects.all().order_by('person_id')
                
            for person in qSet:
                people.append(getPersonAttrs(person))

            return render(request, 'detailed.html', {'people': people})
        else:
            return redirect(noPermission)
    else:
        return redirect(login)

def noPermission(request):
    return render(request, 'nopermission.html')

def editEntity(request, person_id):
    check = sessionCheck(request)
    if check[0]:
        if person_id == request.session['usr_info'][0]:
            return render(request, 'entityedit.html', {"id":person_id})
        elif check[1]:
            return render(request, 'entityedit.html', {"id":person_id})
        else:
            return redirect(noPermission)
    else:
        return redirect(login)