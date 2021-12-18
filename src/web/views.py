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
            if request.method == 'POST': # Filter users by first name
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

def editEntity(request, person_id): # Edit person attributes
    check = sessionCheck(request)
    if check[0]:
        if check[1]:
            person = Person.objects.get(person_id=person_id)
            oldAttrs = getPersonAttrs(person)

            roles = Role.getAll()
            faculties = Faculty.getAll()
            departments = Department.getAll()
            programs = StudyProgram.getAll()
            subjects = Subject.getAll()

            if request.method == 'POST': # Save edited attributes
                post = request.POST
                editAttrs = getEditedAttrs(post, person)

                with transaction.atomic():
                    setPersonAttributes(person, editAttrs)
                    logger.info("Edited user")

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

def createEntity(request): # Create new person
    check = sessionCheck(request)
    if check[0]:
        if check[1]:
            roles = Role.getAll()
            faculties = Faculty.getAll()
            departments = Department.getAll()
            programs = StudyProgram.getAll()
            subjects = Subject.getAll()

            attrs = {
                'allRoles': roles,
                'allFacs': faculties,
                'allDeps': departments,
                'allProgs': programs,
                'allSubjs': subjects
            }

            if request.method == 'POST':
                person = Person()
                attrs = getEditedAttrs(request.POST, person)
                if request.POST['Password'] == request.POST['RPassword']:
                    person.passwd = hashPw(request.POST['Password'])

                    with transaction.atomic():
                        setPersonAttributes(person, attrs)
                        
                    logging.info("Person was created")
                    return redirect(home)
                else:
                    return HttpResponse("<script>alert('Passwords don't match!'); document.location = '/createEntity'</script>")
            else:
                return render(request, 'entitycreate.html', attrs)
        else:
            return redirect(home)
    else:
        redirect(login)

def deleteEntity(request): # Deletes selected people
    check = sessionCheck(request)
    if check[0]:
        if check[1]:
            people = []
            delete = False

            if request.method == 'POST': 
                usr_guery = request.POST.get('query')
                if usr_guery is not None: # Filter users by first name
                    qSet = Person.objects.filter(name__icontains=usr_guery).all().order_by('person_id')
                
                else: # Initialize removal of individual people
                    qSet = Person.objects.all().order_by('person_id')
                    delete = True
            else:
                qSet = Person.objects.all().order_by('person_id') 

            for person in qSet: # Loop over people and remove wanted
                    if delete and str(person.person_id) in dict(request.POST).keys():
                        person.delete()
                        logging.info("Person removed from DB")
                        continue
                    else:
                        roles = PersonHasRole.objects.filter(person=person).select_related()
                        roles = [str(qSet.role.role_type) for qSet in roles.all()]
                        attrs = {
                            'id': person.person_id,
                            'name': person.name,
                            'surname': person.surname,
                            'birthdate': person.birthdate,
                            'email': person.email,
                            'roles': roles
                        }
                        people.append(attrs)

            return render(request, 'entitydelete.html', {'people': people})
        else:
            return redirect(home)
    else:
        return redirect(login)

def sqlInjection(request):
    check = sessionCheck(request)
    if check[0]:
        if check[1]:
            result = ""
            if request.method == 'POST': 
                usr_guery = request.POST.get('query')
                sql_query = f"SELECT person_id, email FROM person WHERE name='{usr_guery}';"
                result = []
                for person in Person.objects.raw(sql_query):
                    result.append(person.email)
            return render(request, 'sqlInjection.html', {'result': result})
        else:
            return redirect(home)
    else:
        return redirect(login)