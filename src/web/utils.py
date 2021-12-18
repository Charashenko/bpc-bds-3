from .models import *
from django.shortcuts import render, redirect
import bcrypt

def getPersonAttrs(person): # Gets person attributes
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

    programs = ProgramHasPerson.objects.filter(person=person).select_related()
    programs = [str(qSet.program.name) for qSet in programs.all()]

    subjects = PersonHasSubject.objects.filter(person=person).select_related()
    subjects = [str(qSet.subject.name) for qSet in subjects.all()]

    try:
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
        'programs': programs,
        'subjects': subjects,
        'thesis': thesis
    }

    return attrs

def sessionCheck(request): # Checks if user is logged in and has 'sysadmin' role
    if request.session.has_key('usrInfo'):
        usrInfo = request.session['usrInfo']
        if 'sysadmin' in usrInfo[2]:
            return (True, True)
        else:
            return (True, False)
    return (False, False)

def getEditedAttrs(post, person): # Gets edited attributes from edit page
    attrs = getPersonAttrs(person)

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

    attrs['person']['Name'] = post.get('Name')
    attrs['person']['Surname'] = post.get('Surname')
    if post.get('Birthdate') != "":
        attrs['person']['Birthdate'] = post.get('Birthdate')
    attrs['person']['Email'] = post.get('Email')
    attrs['person']['Note'] = post.get('Note')
    
    temp = []
    for item in roles:
        if not post.get(item) is None:
            temp.append(post.get(item))
    attrs['roles'] = temp

    temp = []
    for item in faculties:
        if not post.get(item) is None:
            temp.append(post.get(item))
    attrs['faculties'] = temp
    
    temp = []
    for item in departments:
        if not post.get(item) is None:
            temp.append(post.get(item))
    attrs['departments'] = temp
    
    temp = []
    for item in programs:
        if not post.get(item) is None:
            temp.append(post.get(item))
    attrs['programs'] = temp
    
    temp = []
    for item in subjects:
        if not post.get(item) is None:
            temp.append(post.get(item))
    attrs['subjects'] = temp

    return attrs

def setPersonAttributes(person, attrs):
    person.name = attrs['person']['Name']
    person.surname = attrs['person']['Surname']
    person.birthdate = attrs['person']['Birthdate']
    person.email = attrs['person']['Email']
    person.additional_note = attrs['person']['Note']
    person.save()

    # Get all roles and add or remove as needed
    roles = [role for role in Role.objects.all()]
    for role in roles:
        filtered = PersonHasRole.objects.filter(role=role, person=person)
        if role.role_type in attrs['roles']:
            if not filtered:
                phr = PersonHasRole(role=role, person=person)
                phr.save()
        else:
            if filtered:
                phr = filtered.get()
                phr.delete()

    # Get all faculties and add or remove as needed
    faculties = [faculty for faculty in Faculty.objects.all()]
    for faculty in faculties:
        filtered = FacultyHasPerson.objects.filter(faculty=faculty, person=person)
        if faculty.name in attrs['faculties']:
            if not filtered:
                fhp = FacultyHasPerson(faculty=faculty, person=person)
                fhp.save()
        else:
            if filtered:
                fhp = filtered.get()
                fhp.delete()


    # Get all departments and add or remove as needed
    departments = [department for department in Department.objects.all()]
    for department in departments:
        filtered = DepartmentHasPerson.objects.filter(department=department, person=person)
        if department.name in attrs['departments']:
            if not filtered:
                dhp = DepartmentHasPerson(department=department, person=person)
                dhp.save()
        else:
            if filtered:
                dhp = filtered.get()
                dhp.delete()

    # Get all programs and add or remove as needed
    programs = [program for program in StudyProgram.objects.all()]
    for program in programs:
        filtered = ProgramHasPerson.objects.filter(program=program, person=person)
        if program.name in attrs['programs']:
            if not filtered:
                php = ProgramHasPerson(program=program, person=person)
                php.save()
        else:
            if filtered:
                php = filtered.get()
                php.delete()

    # Get all subjects and add or remove as needed
    subjects = [subject for subject in Subject.objects.all()]
    for subject in subjects:
        filtered = PersonHasSubject.objects.filter(subject=subject, person=person)
        if subject.name in attrs['subjects']:
            if not filtered:
                phs = PersonHasSubject(subject=subject, person=person)
                phs.save()
        else:
            if filtered:
                phs = filtered.get()
                phs.delete()

def hashPw(passwd):
    return bcrypt.hashpw(passwd.encode("utf-8"), bcrypt.gensalt()).decode("utf-8")