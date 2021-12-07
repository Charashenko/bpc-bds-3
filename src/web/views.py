from django.shortcuts import render, HttpResponse, redirect
from .models import *
from .forms import LoginForm
from django.db import connection

def sessionCheck(request):
    if request.session.has_key('usr_info'):
        usr_info = request.session['usr_info']
        if 'sysadmin' in usr_info[2]:
            return (True, True)
        else:
            return (True, False)
    return (False, False)

def home(request):
    if sessionCheck(request)[0]:
        if sessionCheck(request)[1]:
            usr_id = request.session['usr_info'][0]
            person = Person.objects.get(person_id=usr_id)

            contacts = Contact.objects.filter(person=person)
            contacts = [str(contact).split(", ") for contact in contacts.all()]

            addresses = PersonHasAddress.objects.filter(person=person).select_related()
            addresses = [str(qSet.address) for qSet in addresses.all()]
            
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
            
            try:
                thesis = Thesis.objects.get(person=person)
            except:
                thesis = None

            params = {
                'person': {
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

            return render(request, 'home.html', params)
        else:
            return render(request, 'home.html', {'name':usr_info[1]})
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
    if sessionCheck(request)[0]:
        if sessionCheck(request)[1]:
            if request.method == 'GET':
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
            return redirect(noPermission)
    else:
        return redirect(login)
