from django.shortcuts import render, HttpResponse, redirect
from .models import *
from .forms import LoginForm
from django.contrib import messages

def getPersonAttrs(person):
    contacts = Contact.objects.filter(person=person)
    contacts = [[str(contact.getType()), str(contact.getValue())] for contact in contacts.all()]

    addresses = PersonHasAddress.objects.filter(person=person).select_related()
    addresses = [[str(qSet.address_type), str(qSet.address)] for qSet in addresses.all()]

    roles = PersonHasRole.objects.filter(person=person).select_related()
    roles = [str(qSet.role.role_type) for qSet in roles.all()]

    faculties = FacultyHasPerson.objects.filter(person=person).select_related()
    faculties = [str(qSet.faculty.name) for qSet in faculties.all()]

    departments = DepartmentHasPerson.objects.filter(person=person).select_related()
    departments = [str(qSet.department.name) for qSet in departments.all()]

    programmes = ProgramHasPerson.objects.filter(person=person).select_related()
    programmes = [str(qSet.program.name) for qSet in programmes.all()]

    subjects = PersonHasSubject.objects.filter(person=person).select_related()
    subjects = [str(qSet.subject.name) for qSet in subjects.all()]

    try: # TODO Logging
        thesis = Thesis.objects.get(person=person)
    except:
        thesis = None

    attrs = {
        'person': {
            'Id': person.getId(),
            'Name': person.getName(),
            'Surname': person.getSurname(),
            'Birthdate': person.getBirthdate(),
            'Email': person.getEmail(),
            'Passwd': person.getPasswd(),
            'Note': person.getNote()
        },
        'addresses': addresses,
        'contacts': contacts,
        'roles': roles,
        'faculties': faculties,
        'departments': departments,
        'programmes': programmes,
        'subjects': subjects,
        'thesis': thesis
    }

    return attrs

def sessionCheck(request):
    if request.session.has_key('usr_info'):
        usr_info = request.session['usr_info']
        if 'sysadmin' in usr_info[2]:
            return (True, True)
        else:
            return (True, False)
    return (False, False)

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
            print("change own")
            return HttpResponse(f"hello {person_id}, editing own")
        elif check[1]:
            print("change other")
            return HttpResponse(f"hello {person_id}, editing other")
        else:
            return redirect(noPermission)
    else:
        return redirect(login)