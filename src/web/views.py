from django.shortcuts import render, HttpResponse, redirect
from .models import *
from .forms import LoginForm
from django.contrib import messages
from .utils import *
from django.db import DatabaseError, transaction
import logging

logger = logging.getLogger('django')

def home(request): # Home/Index page
    check = sessionCheck(request)
    if check[0]:
        usrInfo = request.session['usrInfo']
        person = Person.objects.get(person_id=usrInfo[0])

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

def login(request): # Login page
    email = 'none'
    if request.method == 'POST':
        newLogin = LoginForm(request.POST)
        if newLogin.is_valid():
            logger.info(f'Login attempt successful from {request.META["REMOTE_ADDR"]}')
            request.session['usrInfo'] = newLogin.getUserInfo()
            
            return redirect(home)
        else:
            causeMsg = newLogin.errors.popitem()[1][0]
            logger.warning(f'Login attempt failed from {request.META["REMOTE_ADDR"]} because of {causeMsg}')
            
            return render(request, "login.html",
            {'invalid': causeMsg})
    return render(request, "login.html", {'invalid': ""})

def logout(request): # Logout
    if sessionCheck(request)[0]:
        del request.session['usrInfo']
    return redirect(login)

def detailed(request): # Detailed view of all people
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
            logger.warning(f'Prohibited request from remote host {request.META["REMOTE_ADDR"]}')
            return redirect(home)
    else:
        return redirect(login)

def noPermission(request):
    return render(request, 'nopermission.html')

def editEntity(request, person_id): # Edit person attributes
    check = sessionCheck(request)
    if check[0]:
        if check[1]:
            person = Person.objects.get(person_id=person_id)
            oldAttrs = getPersonAttrs(person)

            roles = Role.objects.all()
            roles = [str(qSet.role_type) for qSet in roles]

            faculties = Faculty.objects.all()
            faculties = [str(qSet.name) for qSet in faculties]

            departments = Department.objects.all()
            departments = [str(qSet.name) for qSet in departments]

            programs = StudyProgram.objects.all()
            programs = [str(qSet.name) for qSet in programs]

            subjects = Subject.objects.all()
            subjects = [str(qSet.name) for qSet in subjects]

            if request.method == 'POST':
                post = request.POST
                editAttrs = getEditedAttrs(post, person)

                with transaction.atomic():
                        setPersonAttributes(person, editAttrs)

                return render(request, 'entityedit.html', {
                    'attrs': editAttrs,
                    'allRoles': roles,
                    'allFacs': faculties,
                    'allDeps': departments,
                    'allProgs': programs,
                    'allSubjs': subjects
                })
            else:   
                return render(request, 'entityedit.html', {
                    'attrs': oldAttrs,
                    'allRoles': roles,
                    'allFacs': faculties,
                    'allDeps': departments,
                    'allProgs': programs,
                    'allSubjs': subjects
                })
        else:
            return redirect(home)
    else:
        return redirect(login)